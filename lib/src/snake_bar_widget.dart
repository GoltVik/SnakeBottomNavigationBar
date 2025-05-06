import 'package:flutter/material.dart';

import '../snake_navigation_bar.dart';
import 'snake_item_tile.dart';
import 'snake_view.dart';
import 'theming/selection_style.dart';
import 'theming/snake_bottom_bar_theme.dart';
import 'utils/extensions.dart';

/// default animation duration for the snake bar
const _defaultAnimationDuration = kThemeChangeDuration;

class SnakeNavigationBar extends StatefulWidget {
  //region Properties
  final List<BottomNavigationBarItem>? items;

  /// If [SnakeBarBehaviour.floating] this color is
  /// used as background color of shaped view.
  /// If [SnakeBarBehaviour.pinned] this color just
  /// a background color of whole [SnakeNavigationBar] view
  final Gradient? backgroundGradient;

  /// This color represents a SnakeView and unselected
  /// Icon and label color
  final Gradient? snakeViewGradient;

  /// This color represents a selected Icon color
  final Gradient? selectedItemGradient;

  /// This color represents a unselected Icon color
  final Gradient? unselectedItemGradient;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showSelectedLabels;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showUnselectedLabels;

  /// The index into [items] for the current active [BottomNavigationBarItem].
  final int currentIndex;

  ///You can specify custom elevation shadow color
  final Color shadowColor;

  /// Defines the [SnakeView] shape and behavior of a [SnakeNavigationBar].
  ///
  /// See documentation for [SnakeShape] for information on the
  /// meaning of different shapes.
  ///
  /// Default is [SnakeShape.circle]
  final SnakeShape snakeShape;

  /// Defines the layout and behavior of a [SnakeNavigationBar].
  ///
  /// See documentation for [SnakeBarBehaviour] for information on the
  /// meaning of different styles.
  ///
  /// Default is [SnakeBarBehaviour.pinned]
  final SnakeBarBehaviour behaviour;

  /// You can define custom [ShapeBorder] with padding and elevation to [SnakeNavigationBar]
  final ShapeBorder? shape;
  final EdgeInsets padding;
  final double elevation;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are
  /// selected.
  final TextStyle? selectedLabelStyle;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are not
  /// selected.
  final TextStyle? unselectedLabelStyle;

  /// Called when one of the [items] is pressed.
  final ValueChanged<int>? onTap;

  final SelectionStyle _selectionStyle;

  /// BottomNavigationBar height default is [kBottomNavigationBarHeight]
  final double height;

  final bool useSafeArea;

  //endregion

  // region Constructor
  SnakeNavigationBar._(
    this._selectionStyle, {
    super.key,
    this.snakeViewGradient,
    this.backgroundGradient,
    this.selectedItemGradient,
    this.unselectedItemGradient,
    bool showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.items,
    this.currentIndex = 0,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.elevation = 0,
    this.onTap,
    this.behaviour = SnakeBarBehaviour.pinned,
    this.snakeShape = const SnakeShape.circle(),
    this.shadowColor = Colors.black,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    required this.height,
    this.useSafeArea = true,
  }) : showSelectedLabels =
            (snakeShape.type == SnakeShapeType.circle && showSelectedLabels)
                ? false
                : showSelectedLabels;

  factory SnakeNavigationBar.color({
    Key? key,
    Color? snakeViewColor,
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    bool showSelectedLabels = false,
    bool showUnselectedLabels = false,
    List<BottomNavigationBarItem>? items,
    int currentIndex = 0,
    ShapeBorder? shape,
    EdgeInsets padding = EdgeInsets.zero,
    double elevation = 0.0,
    ValueChanged<int>? onTap,
    SnakeBarBehaviour behaviour = SnakeBarBehaviour.pinned,
    SnakeShape snakeShape = const SnakeShape.circle(),
    Color shadowColor = Colors.black,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    double? height,
    bool useSafeArea = true,
  }) =>
      SnakeNavigationBar._(
        SelectionStyle.color,
        key: key,
        snakeViewGradient: snakeViewColor?.gradient,
        backgroundGradient: backgroundColor?.gradient,
        selectedItemGradient: selectedItemColor?.gradient,
        unselectedItemGradient: unselectedItemColor?.gradient,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        items: items,
        currentIndex: currentIndex,
        shape: shape,
        padding: padding,
        elevation: elevation,
        onTap: onTap,
        behaviour: behaviour,
        snakeShape: snakeShape,
        shadowColor: shadowColor,
        selectedLabelStyle: selectedLabelStyle,
        unselectedLabelStyle: unselectedLabelStyle,
        height: height ?? kBottomNavigationBarHeight,
        useSafeArea: useSafeArea,
      );

  factory SnakeNavigationBar.gradient({
    Key? key,
    Gradient? snakeViewGradient,
    Gradient? backgroundGradient,
    Gradient? selectedItemGradient,
    Gradient? unselectedItemGradient,
    bool showSelectedLabels = false,
    bool showUnselectedLabels = false,
    List<BottomNavigationBarItem>? items,
    int currentIndex = 0,
    ShapeBorder? shape,
    EdgeInsets padding = EdgeInsets.zero,
    double elevation = 0.0,
    ValueChanged<int>? onTap,
    SnakeBarBehaviour behaviour = SnakeBarBehaviour.pinned,
    SnakeShape snakeShape = const SnakeShape.circle(),
    Color shadowColor = Colors.black,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    double? height,
    bool useSafeArea = true,
  }) =>
      SnakeNavigationBar._(
        SelectionStyle.gradient,
        key: key,
        snakeViewGradient: snakeViewGradient,
        backgroundGradient: backgroundGradient,
        selectedItemGradient: selectedItemGradient,
        unselectedItemGradient: unselectedItemGradient,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        items: items,
        currentIndex: currentIndex,
        shape: shape,
        padding: padding,
        elevation: elevation,
        onTap: onTap,
        behaviour: behaviour,
        snakeShape: snakeShape,
        shadowColor: shadowColor,
        selectedLabelStyle: selectedLabelStyle,
        unselectedLabelStyle: unselectedLabelStyle,
        height: height ?? kBottomNavigationBarHeight,
        useSafeArea: useSafeArea,
      );

  //endregion

  @override
  State<SnakeNavigationBar> createState() => _SnakeNavigationBarState();
}

class _SnakeNavigationBarState extends State<SnakeNavigationBar> {
  late SnakeBarThemeData theme = _createTheme(context);
  late int _currentIndex = widget.currentIndex;

  SnakeBarThemeData _createTheme(BuildContext context) {
    final snakeBarTheme = SnakeBottomBarTheme.of(context);
    return snakeBarTheme ??
        () {
          final theme = Theme.of(context);
          final bottomNavigationBarTheme = BottomNavigationBarTheme.of(context);
          return SnakeBarThemeData(
            snakeGradient: widget.snakeViewGradient ??
                theme.colorScheme.secondary.gradient,
            backgroundGradient: widget.backgroundGradient ??
                bottomNavigationBarTheme.backgroundColor?.gradient ??
                theme.cardColor.gradient,
            selectedItemGradient: widget.selectedItemGradient ??
                bottomNavigationBarTheme.selectedItemColor?.gradient ??
                theme.cardColor.gradient,
            unselectedItemGradient: widget.unselectedItemGradient ??
                bottomNavigationBarTheme.unselectedItemColor?.gradient ??
                theme.colorScheme.secondary.gradient,
            showSelectedLabels: widget.showSelectedLabels,
            showUnselectedLabels: widget.showUnselectedLabels,
            snakeShape: widget.snakeShape,
            selectionStyle: widget._selectionStyle,
            selectedLabelStyle: widget.selectedLabelStyle,
            unselectedLabelStyle: widget.unselectedLabelStyle,
          );
        }();
  }

  @override
  void didUpdateWidget(covariant SnakeNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    theme = _createTheme(context);
  }

  @override
  Widget build(BuildContext context) {
    final safeMargin =
        widget.behaviour == SnakeBarBehaviour.floating && widget.useSafeArea
            ? MediaQuery.of(context).viewPadding
            : EdgeInsets.zero;

    final safePadding =
        widget.behaviour == SnakeBarBehaviour.floating || !widget.useSafeArea
            ? EdgeInsets.zero
            : MediaQuery.of(context).viewPadding;

    return SnakeBottomBarTheme(
      data: theme,
      child: AnimatedPadding(
        padding: widget.padding + safeMargin,
        duration: _defaultAnimationDuration,
        child: Material(
          type: MaterialType.transparency,
          clipBehavior: Clip.antiAlias,
          shadowColor: widget.shadowColor,
          elevation: widget.elevation,
          shape: widget.shape,
          child: AnimatedContainer(
            duration: _defaultAnimationDuration,
            decoration: BoxDecoration(gradient: theme.backgroundGradient),
            padding: safePadding,
            child: Stack(
              alignment: widget.snakeShape.alignment,
              children: [
                SnakeView(
                  itemsCount: widget.items!.length,
                  height: widget.height + 8,
                  widgetEdgePadding: widget.padding.left + widget.padding.right,
                  selection: _currentIndex,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final (index, value) in widget.items!.indexed)
                      SnakeItemTile(
                        icon: value.icon,
                        activeIcon: value.activeIcon,
                        label: value.label,
                        position: index,
                        height: widget.height,
                        isSelected: _currentIndex == index,
                        onTap: () => setState(() {
                          _currentIndex = index;
                          widget.onTap?.call(index);
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
