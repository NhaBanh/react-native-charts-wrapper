//
//  RNBIOHCandleStickChartManagerBridge.m
//  RNCharts
//
//  Created by Nha Banh on 6/8/21.
//

#import "React/RCTViewManager.h"
#import "React/RCTBridgeModule.h"
#import "RNChartManagerBridge.h"
#import "RNYAxisChartManagerBridge.h"
#import "RNBarLineChartManagerBridge.h"


@interface RCT_EXTERN_MODULE(RNBIOHCandleStickChartManager, RCTViewManager)

EXPORT_BAR_LINE_CHART_BASE_PROPERTIES

@end
