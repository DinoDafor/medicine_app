import 'dart:ui' as ui;
import 'package:flutter/material.dart';


MediaQueryData mediaQueryData = MediaQueryData.fromWindow(ui.window);

const num FIGMA_DESIGN_WIDTH = 414;
const num FIGMA_DESIGN_HEIGHT = 896;
const num FIGMA_DESIGN_STATUS_BAR = 0;

extension ResponsiveExtension on num {
  get _width {
    return mediaQueryData.size.width;
  }

  get _height {
    num statusBar = mediaQueryData.viewPadding.top;
    num bottomBar = mediaQueryData.viewPadding.bottom;
    num screenHeight = mediaQueryData.size.height - statusBar - bottomBar;
    return screenHeight;
  }

  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);

  double get v =>
      (this * _height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR);

  double get adaptSize {
    var height = v;
    var width = h;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  double get fSize => adaptSize;
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }
}
