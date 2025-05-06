import 'package:flutter/widgets.dart';

import '../../snake_navigation_bar.dart';
import 'selection_style.dart';

class SnakeBottomBarTheme extends InheritedWidget {
  const SnakeBottomBarTheme({
    required this.data,
    super.key,
    required super.child,
  });

  final SnakeBarThemeData data;

  static SnakeBarThemeData? of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<SnakeBottomBarTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(SnakeBottomBarTheme oldWidget) => false;
}

class SnakeBarThemeData {
  final Gradient snakeGradient;
  final Gradient backgroundGradient;
  final Gradient selectedItemGradient;
  final Gradient unselectedItemGradient;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final SnakeShape snakeShape;
  final SelectionStyle selectionStyle;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  const SnakeBarThemeData({
    required this.snakeGradient,
    required this.backgroundGradient,
    required this.selectedItemGradient,
    required this.unselectedItemGradient,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    required this.snakeShape,
    required this.selectionStyle,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
  });
}
