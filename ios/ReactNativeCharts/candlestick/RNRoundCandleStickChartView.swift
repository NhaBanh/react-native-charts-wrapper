//
//  RNRoundCandleStickChartView.swift
//  Charts
//
//  Created by Nha Banh on 5/20/21.
//

import Charts
import SwiftyJSON

class RNRoundCandleStickChartView: RNBarLineChartViewBase {
    
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
        self._chart.renderer = RoundCandleStickChartRenderer(dataProvider: _chart, animator: _chart.chartAnimator, viewPortHandler: _chart.viewPortHandler)
        self._dataExtract = CandleDataExtract()
        super.init(frame: frame);
      
        self._chart.delegate = self
        self.addSubview(_chart);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
