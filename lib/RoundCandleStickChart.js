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

class RoundCandleStickChart extends React.Component {
  getNativeComponentName() {
    return 'RNRoundCandleStickChart'
  }

  getNativeComponentRef() {
    return this.nativeComponentRef
  }

  render() {
    return <RNRoundCandleStickChart {...this.props} ref={ref => this.nativeComponentRef = ref} />;
  }

}

RoundCandleStickChart.propTypes = {
  ...BarLineChartBase.propTypes,

  data: candleData
};

var RNRoundCandleStickChart = requireNativeComponent('RNRoundCandleStickChart', RoundCandleStickChart, {
  nativeOnly: {onSelect: true, onChange: true}
});

export default ScrollEnhancer(HighlightEnhancer(ScaleEnhancer(MoveEnhancer(RoundCandleStickChart))))
