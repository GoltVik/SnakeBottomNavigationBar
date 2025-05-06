import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../snake_navigation_bar.dart';
import 'theming/snake_bottom_bar_theme.dart';

class SnakeView extends StatefulWidget {
  final int itemsCount;
  final double widgetEdgePadding;

  final Duration animationDuration;
  final Duration delayTransition;
  final Curve snakeCurve;
  final double indicatorHeight;
  final double height;
  final int selection;

  const SnakeView({
    super.key,
    required this.itemsCount,
    required this.widgetEdgePadding,
    this.animationDuration = const Duration(milliseconds: 200),
    this.delayTransition = const Duration(milliseconds: 50),
    this.snakeCurve = Curves.easeInOut,
    this.indicatorHeight = 4,
    required this.height,
    required this.selection,
  });

  @override
  State<SnakeView> createState() => _SnakeViewState();
}

class _SnakeViewState extends State<SnakeView> {
  double left = 0;
  int snakeSize = 1;
  Orientation? orientation;
  double? oneItemWidth;
  double? prevItemWidth;

  bool get isRTL => Directionality.of(context) == TextDirection.rtl;

  int _lastIndex = 0;
  int _currentIndex = 0;

  @override
  void didUpdateWidget(covariant SnakeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selection != widget.selection) {
      _lastIndex = _currentIndex;
      _currentIndex = widget.selection;
      if (_lastIndex < _currentIndex) {
        _goRight();
      } else if (_lastIndex > _currentIndex) {
        _goLeft();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selection;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = SnakeBottomBarTheme.of(context)!;

    oneItemWidth =
        (MediaQuery.of(context).size.width - widget.widgetEdgePadding) /
            widget.itemsCount;

    if (orientation != mediaQuery.orientation ||
        prevItemWidth != oneItemWidth) {
      left = oneItemWidth! * _currentIndex;
      orientation = mediaQuery.orientation;
      prevItemWidth = oneItemWidth;
    }

    final viewPadding = theme.snakeShape.type == SnakeShapeType.circle ||
            theme.snakeShape.centered
        ? () {
            final maxSize = math.min(oneItemWidth!, widget.height);
            return EdgeInsets.symmetric(
                  vertical: (widget.height - maxSize) / 2,
                  horizontal: (oneItemWidth! - maxSize) / 2,
                ) +
                theme.snakeShape.padding;
          }()
        : theme.snakeShape.padding;

    final snakeViewWidth = oneItemWidth! * snakeSize - viewPadding.horizontal;

    return AnimatedPositioned(
      left: isRTL ? null : left,
      right: isRTL ? left : null,
      duration: widget.animationDuration,
      curve: widget.snakeCurve,
      child: AnimatedContainer(
        margin: viewPadding,
        curve: widget.snakeCurve,
        duration: widget.animationDuration,
        width: snakeViewWidth,
        height: _snakeViewHeight(theme),
        child: Material(
          shape: _snakeShape(theme),
          clipBehavior: Clip.antiAlias,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: SnakeBottomBarTheme.of(context)!.snakeGradient,
            ),
          ),
        ),
      ),
    );
  }

  double _snakeViewHeight(SnakeBarThemeData theme) {
    switch (theme.snakeShape.type) {
      case SnakeShapeType.circle:
        final maxSize = math.min(oneItemWidth!, widget.height);
        return maxSize - theme.snakeShape.padding.vertical;
      case SnakeShapeType.indicator:
        return widget.indicatorHeight;
      default:
        return widget.height - theme.snakeShape.padding.vertical;
    }
  }

  ShapeBorder? _snakeShape(SnakeBarThemeData theme) {
    return switch (theme.snakeShape.type) {
      SnakeShapeType.circle => _getRoundShape(_snakeViewHeight(theme) / 2),
      _ => theme.snakeShape.shape
    };
  }

  void _goRight() {
    final newSnakeSize = _currentIndex + 1 - _lastIndex;
    setState(() => snakeSize = newSnakeSize);
    Future.delayed(
      widget.animationDuration + widget.delayTransition,
      () => setState(() {
        snakeSize = 1;
        left = oneItemWidth! * _currentIndex;
      }),
    );
  }

  void _goLeft() {
    final newSnakeSize = (_currentIndex - _lastIndex).abs();
    setState(() {
      left = oneItemWidth! * _currentIndex;
      snakeSize = newSnakeSize + 1;
    });
    Future.delayed(
      widget.animationDuration + widget.delayTransition,
      () => setState(() => snakeSize = 1),
    );
  }

  ShapeBorder _getRoundShape(double radius) => RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );
}
