//
//  RNBIOHCandleStickChartManager.swift
//  RNCharts
//
//  Created by Nha Banh on 6/8/21.
//

import UIKit

@objc(RNBIOHCandleStickChartManager)
@objcMembers
open class RNBIOHCandleStickChartManager: RCTViewManager, RNBarLineChartBaseManager {
  var _bridge: RCTBridge? {get{return self.bridge}}
  
  override open func view() -> UIView! {
    let ins = RNBIOHCandleStickChartView()
    return ins;
  }

  override public static func requiresMainQueueSetup() -> Bool {
    return true;
  }
  
  func moveViewToX(_ reactTag: NSNumber, xValue: NSNumber) {
    (self as RNBarLineChartBaseManager)._moveViewToX(reactTag, xValue: xValue)
  }
  
  func moveViewTo(_ reactTag: NSNumber, xValue: NSNumber, yValue: NSNumber, axisDependency: NSString) {
    (self as RNBarLineChartBaseManager)._moveViewTo(reactTag, xValue: xValue, yValue: yValue, axisDependency: axisDependency)
  }
  
  func moveViewToAnimated(_ reactTag: NSNumber, xValue: NSNumber, yValue: NSNumber, axisDependency: NSString, duration: NSNumber) {
    (self as RNBarLineChartBaseManager)._moveViewToAnimated(reactTag, xValue: xValue, yValue: yValue, axisDependency: axisDependency, duration: duration)
  }
  
  func centerViewTo(_ reactTag: NSNumber, xValue: NSNumber, yValue: NSNumber, axisDependency: NSString) {
    (self as RNBarLineChartBaseManager)._centerViewTo(reactTag, xValue: xValue, yValue: yValue, axisDependency: axisDependency)
  }
  
  func centerViewToAnimated(_ reactTag: NSNumber, xValue: NSNumber, yValue: NSNumber, axisDependency: NSString, duration: NSNumber) {
    (self as RNBarLineChartBaseManager)._centerViewToAnimated(reactTag, xValue: xValue, yValue: yValue, axisDependency: axisDependency, duration: duration)
  }
  
  func fitScreen(_ reactTag: NSNumber) {
    (self as RNBarLineChartBaseManager)._fitScreen(reactTag)
  }
  
  func highlights(_ reactTag: NSNumber, config: NSArray) {
    (self as RNBarLineChartBaseManager)._highlights(reactTag, config: config)
  }

  func setDataAndLockIndex(_ reactTag: NSNumber, data: NSDictionary) {
    (self as RNBarLineChartBaseManager)._setDataAndLockIndex(reactTag, data: data)
  }

}
