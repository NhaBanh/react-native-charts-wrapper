package com.github.wuxudong.rncharts.charts;

import com.facebook.react.uimanager.ThemedReactContext;
import com.github.mikephil.charting.charts.CandleStickChart;
import com.github.mikephil.charting.data.CandleEntry;
import com.github.wuxudong.rncharts.charts.custom.BIOHCandleChartRenderer;
import com.github.wuxudong.rncharts.data.CandleDataExtract;
import com.github.wuxudong.rncharts.data.DataExtract;
import com.github.wuxudong.rncharts.listener.RNOnChartGestureListener;
import com.github.wuxudong.rncharts.listener.RNOnChartValueSelectedListener;


public class RoundCandleStickChartManager extends BarLineChartBaseManager<CandleStickChart, CandleEntry> {
    @Override
    public String getName() {
        return "RNRoundCandleStickChart";
    }

    @Override
    protected CandleStickChart createViewInstance(ThemedReactContext reactContext) {
        CandleStickChart candleStickChart = new CandleStickChart(reactContext);
        candleStickChart.setRenderer(new BIOHCandleChartRenderer(
                candleStickChart,
                candleStickChart.getAnimator(),
                candleStickChart.getViewPortHandler()
        ));
        candleStickChart.setOnChartValueSelectedListener(new RNOnChartValueSelectedListener(candleStickChart));
        candleStickChart.setOnChartGestureListener(new RNOnChartGestureListener(candleStickChart));
        return candleStickChart;
    }

    @Override
    DataExtract getDataExtract() {
        return new CandleDataExtract();
    }

}
