import 'package:flutter/material.dart';

sealed class SnakeShape {
  const SnakeShape({
    required this.type,
    required this.shape,
    required this.centered,
    required this.padding,
    required this.alignment,
  });

  final SnakeShapeType type;
  final ShapeBorder shape;
  final bool centered;
  final EdgeInsets padding;
  final AlignmentGeometry alignment;

  const factory SnakeShape.circle({
    bool? centered,
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
  }) = CircleSnakeShape;

  const factory SnakeShape.rectangle({
    bool? centered,
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
  }) = RectangleSnakeShape;

  const factory SnakeShape.indicator({
    bool? centered,
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
  }) = IndicatorSnakeShape;

  const factory SnakeShape.custom({
    required ShapeBorder shape,
    bool centered,
    EdgeInsets padding,
    AlignmentGeometry alignment,
  }) = CustomSnakeShape;
}

class CircleSnakeShape extends SnakeShape {
  const CircleSnakeShape({
    ShapeBorder? shape,
    bool? centered,
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
  }) : super(
          type: SnakeShapeType.circle,
          shape: shape ?? const CircleBorder(),
          centered: centered ?? true,
          padding: padding ?? const EdgeInsets.all(4),
          alignment: alignment ?? Alignment.center,
        );
}

class RectangleSnakeShape extends SnakeShape {
  const RectangleSnakeShape({
    ShapeBorder? shape,
    bool? centered,
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
  }) : super(
          type: SnakeShapeType.rectangle,
          shape: shape ?? const RoundedRectangleBorder(),
          centered: centered ?? false,
          padding: padding ?? EdgeInsets.zero,
          alignment: alignment ?? Alignment.center,
        );
}

class IndicatorSnakeShape extends SnakeShape {
  const IndicatorSnakeShape({
    ShapeBorder? shape,
    bool? centered,
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
  }) : super(
          type: SnakeShapeType.indicator,
          shape: shape ?? const RoundedRectangleBorder(),
          centered: centered ?? false,
          padding: padding ?? EdgeInsets.zero,
          alignment: alignment ?? Alignment.topCenter,
        );
}

class CustomSnakeShape extends SnakeShape {
  const CustomSnakeShape({
    required super.shape,
    bool? centered,
    EdgeInsets? padding,
    AlignmentGeometry? alignment,
  }) : super(
          type: SnakeShapeType.custom,
          centered: centered ?? false,
          padding: padding ?? EdgeInsets.zero,
          alignment: alignment ?? Alignment.center,
        );
}

enum SnakeShapeType { circle, rectangle, indicator, custom }
