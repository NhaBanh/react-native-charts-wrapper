//
//  BIOHBarLineScatterCandleBubbleRenderer.swift
//  RNCharts
//
//  Created by Nha Banh on 6/8/21.
//

import Foundation
import CoreGraphics
import Charts

@objc(BIOHBarLineScatterCandleBubbleRenderer)
open class BIOHBarLineScatterCandleBubbleRenderer: DataRenderer
{
    open var _xBounds = XBounds() // Reusable XBounds object
    
    public override init(animator: Animator, viewPortHandler: ViewPortHandler)
    {
        super.init(animator: animator, viewPortHandler: viewPortHandler)
    }
    
    /// Checks if the provided entry object is in bounds for drawing considering the current animation phase.
    open func isInBoundsX(entry e: ChartDataEntry, dataSet: IBarLineScatterCandleBubbleChartDataSet) -> Bool
    {
        let entryIndex = dataSet.entryIndex(entry: e)
        return Double(entryIndex) < Double(dataSet.entryCount) * animator.phaseX
    }

    /// Calculates and returns the x-bounds for the given DataSet in terms of index in their values array.
    /// This includes minimum and maximum visible x, as well as range.
    internal func xBounds(chart: BarLineScatterCandleBubbleChartDataProvider,
                          dataSet: IBarLineScatterCandleBubbleChartDataSet,
                          animator: Animator?) -> XBounds
    {
        return XBounds(chart: chart, dataSet: dataSet, animator: animator)
    }
    
    /// - Returns: `true` if the DataSet values should be drawn, `false` if not.
    open func shouldDrawValues(forDataSet set: IChartDataSet) -> Bool
    {
        return set.isVisible && (set.isDrawValuesEnabled || set.isDrawIconsEnabled)
    }

    /// Class representing the bounds of the current viewport in terms of indices in the values array of a DataSet.
    open class XBounds
    {
        /// minimum visible entry index
        open var min: Int = 0

        /// maximum visible entry index
        open var max: Int = 0

        /// range of visible entry indices
        open var range: Int = 0

        public init()
        {
            
        }
        
        public init(chart: BarLineScatterCandleBubbleChartDataProvider,
                    dataSet: IBarLineScatterCandleBubbleChartDataSet,
                    animator: Animator?)
        {
            self.set(chart: chart, dataSet: dataSet, animator: animator)
        }
        
        /// Calculates the minimum and maximum x values as well as the range between them.
        open func set(chart: BarLineScatterCandleBubbleChartDataProvider,
                      dataSet: IBarLineScatterCandleBubbleChartDataSet,
                      animator: Animator?)
        {
            let phaseX = Swift.max(0.0, Swift.min(1.0, animator?.phaseX ?? 1.0))
            
            let low = chart.lowestVisibleX
            let high = chart.highestVisibleX
            
            let entryFrom = dataSet.entryForXValue(low, closestToY: .nan, rounding: .down)
            let entryTo = dataSet.entryForXValue(high, closestToY: .nan, rounding: .up)
            
            self.min = entryFrom == nil ? 0 : dataSet.entryIndex(entry: entryFrom!)
            self.max = entryTo == nil ? 0 : dataSet.entryIndex(entry: entryTo!)
            range = Int(Double(self.max - self.min) * phaseX)
        }
    }
}

extension BIOHBarLineScatterCandleBubbleRenderer.XBounds: RangeExpression {
    public func relative<C>(to collection: C) -> Swift.Range<Int>
        where C : Collection, Bound == C.Index
    {
        return Swift.Range<Int>(min...min + range)
    }

    public func contains(_ element: Int) -> Bool {
        return (min...min + range).contains(element)
    }
}

extension BIOHBarLineScatterCandleBubbleRenderer.XBounds: Sequence {
    public struct Iterator: IteratorProtocol {
        private var iterator: IndexingIterator<ClosedRange<Int>>
        
        fileprivate init(min: Int, max: Int) {
            self.iterator = (min...max).makeIterator()
        }
        
        public mutating func next() -> Int? {
            return self.iterator.next()
        }
    }
    
    public func makeIterator() -> Iterator {
        return Iterator(min: self.min, max: self.min + self.range)
    }
}

extension BIOHBarLineScatterCandleBubbleRenderer.XBounds: CustomDebugStringConvertible
{
    public var debugDescription: String
    {
        return "min:\(self.min), max:\(self.max), range:\(self.range)"
    }
}
