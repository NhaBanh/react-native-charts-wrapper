import PropTypes from 'prop-types';
import React, {Component} from 'react';
import {
  requireNativeComponent,
  View
} from 'react-native';

import BarLineChartBase from './BarLineChartBase';
import {candleData} from './ChartDataConfig';
import MoveEnhancer from './MoveEnhancer'
import ScaleEnhancer from "./ScaleEnhancer";
import HighlightEnhancer from "./HighlightEnhancer";
import ScrollEnhancer from "./ScrollEnhancer";

class BIOHCandleStickChart extends React.Component {
  getNativeComponentName() {
    return 'RNBIOHCandleStickChart'
  }

  getNativeComponentRef() {
    return this.nativeComponentRef
  }

  render() {
    return <RNBIOHCandleStickChart {...this.props} ref={ref => this.nativeComponentRef = ref} />;
  }

}

BIOHCandleStickChart.propTypes = {
  ...BarLineChartBase.propTypes,

  data: candleData
};

var RNBIOHCandleStickChart = requireNativeComponent('RNBIOHCandleStickChart', BIOHCandleStickChart, {
  nativeOnly: {onSelect: true, onChange: true}
});

export default ScrollEnhancer(HighlightEnhancer(ScaleEnhancer(MoveEnhancer(BIOHCandleStickChart))))
