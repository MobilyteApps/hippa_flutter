import 'package:flutter/material.dart';

class BezierCurveSection {
  Offset start;

  Offset top;

  Offset end;

  double proportion;

  BezierCurveSection({
    required this.start,
    required this.top,
    required this.end,
    this.proportion = 1 / 2,
  })  : assert(proportion > 0),
        assert(proportion < 1);
}

class ThirdOrderBezierCurveSection {
  Offset p1;

  Offset p2;

  Offset p3;

  Offset p4;

  double smooth;

  ThirdOrderBezierCurveSection({
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
    this.smooth = .5,
  })  : assert(smooth >= 0),
        assert(smooth <= 1);
}

class BezierCurveDots {
  double x1;

  double y1;

  double x2;

  double y2;

  BezierCurveDots(
    this.x1,
    this.y1,
    this.x2,
    this.y2,
  );

  List<double> getList() {
    return [x1, y1, x2, y2];
  }

  Map<String, double> getMap() {
    return {
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
    };
  }
}

class ThirdOrderBezierCurveDots {
  double x1;

  double y1;

  double x2;

  double y2;

  double x3;

  double y3;

  ThirdOrderBezierCurveDots(
    this.x1,
    this.y1,
    this.x2,
    this.y2,
    this.x3,
    this.y3,
  );

  List<double> getList() {
    return [x1, y1, x2, y2, x3, y3];
  }

  Map<String, double> getMap() {
    return {
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
      'x3': x3,
      'y3': y3,
    };
  }
}
