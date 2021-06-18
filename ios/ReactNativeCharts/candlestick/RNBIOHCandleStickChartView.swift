//
//  RNBIOHCandleStickChartView.swift
//  RNCharts
//
//  Created by Nha Banh on 6/8/21.
//



import Charts
import SwiftyJSON

class RNBIOHCandleStickChartView: RNBarLineChartViewBase {
    
    let _chart: CandleStickChartView;
    let _dataExtract : CandleDataExtract;
    
    override var chart: ChartViewBase {
        return _chart
    }
    
    override var dataExtract: DataExtract {
        return _dataExtract
    }
    
    
    override init(frame: CoreGraphics.CGRect) {
        self._chart = CandleStickChartView(frame: frame)
        self._chart.renderer = BIOHCandleStickChartRenderer(dataProvider: _chart, animator: _chart.chartAnimator, viewPortHandler: _chart.viewPortHandler)
        self._dataExtract = CandleDataExtract()
        super.init(frame: frame);
      
        self._chart.delegate = self
        self.addSubview(_chart);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
