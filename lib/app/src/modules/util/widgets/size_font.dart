import 'package:flutter/material.dart';

double getValueFont(
    {@required context, double valueMax = 20, double valueMin = 9}) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  Size size = mediaQuery.size;
  if (size.width * 0.03 < valueMax && size.width * 0.03 > valueMin) {
    return size.width * 0.03;
  }
  if (size.width * 0.03 < valueMin) {
    return valueMin;
  } else {
    return valueMax;
  }
}
