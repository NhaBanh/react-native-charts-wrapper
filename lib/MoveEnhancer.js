import React, {Component} from 'react';
import { UIManager, findNodeHandle} from 'react-native';


export default function MoveEnhancer(Chart) {
  return class MoveExtended extends Chart {
    // x, y, left/right
    moveViewTo(x, y, axisDependency) {
      UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.getNativeComponentRef()),
        UIManager.getViewManagerConfig(this.getNativeComponentName()).Commands.moveViewTo,
        [x, y, axisDependency]
      );
    }


    moveViewToX(x) {
      UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.getNativeComponentRef()),
        UIManager.getViewManagerConfig(this.getNativeComponentName()).Commands.moveViewToX,
        [x]
      );
    }

    moveViewToAnimated(x, y, axisDependency, duration) {
      UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.getNativeComponentRef()),
        UIManager.getViewManagerConfig(this.getNativeComponentName()).Commands.moveViewToAnimated,
        [x, y, axisDependency, duration]
      );
    }

    centerViewTo(x, y, axisDependency) {
      UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.getNativeComponentRef()),
        UIManager.getViewManagerConfig(this.getNativeComponentName()).Commands.centerViewTo,
        [x, y, axisDependency]
      );
    }

    centerViewToAnimated(x, y, axisDependency, duration) {
      UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.getNativeComponentRef()),
        UIManager.getViewManagerConfig(this.getNativeComponentName()).Commands.centerViewToAnimated,
        [x, y, axisDependency, duration]
      );
    }

    zoom(scaleX, scaleY, x, y ){
      UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.getNativeComponentRef()),
        UIManager.getViewManagerConfig(this.getNativeComponentName()).Commands.zoom,
        [scaleX, scaleY, x, y]
      );
    }
  }
}