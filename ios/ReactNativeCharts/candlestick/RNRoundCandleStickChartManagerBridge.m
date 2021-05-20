//
//  RNRoundCandleStickChartManagerBridge.m
//  Charts
//
//  Created by Nha Banh on 5/20/21.
//

#import "React/RCTViewManager.h"
#import "React/RCTBridgeModule.h"
#import "RNChartManagerBridge.h"
#import "RNYAxisChartManagerBridge.h"
#import "RNBarLineChartManagerBridge.h"


@interface RCT_EXTERN_MODULE(RNRoundCandleStickChartManager, RCTViewManager)

EXPORT_BAR_LINE_CHART_BASE_PROPERTIES

@end
