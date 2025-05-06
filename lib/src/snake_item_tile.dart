import 'package:flutter/material.dart';

import '../snake_navigation_bar.dart';
import 'theming/selection_style.dart';
import 'theming/snake_bottom_bar_theme.dart';
import 'utils/extensions.dart';

class SnakeItemTile extends StatelessWidget {
  final Widget? icon;
  final String? label;
  final int? position;
  final bool isSelected;
  final VoidCallback? onTap;

  const SnakeItemTile({
    super.key,
    this.icon,
    this.label,
    this.position,
    required this.isSelected,
    this.onTap,
  });

  bool isIndicatorStyle(SnakeBarThemeData theme) =>
      theme.snakeShape.type == SnakeShapeType.indicator;

  @override
  Widget build(BuildContext context) {
    final theme = SnakeBottomBarTheme.of(context)!;

    final showLabels =
        isSelected ? theme.showSelectedLabels : theme.showUnselectedLabels;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Container(
          alignment: Alignment.center,
          margin: theme.snakeShape.padding,
          child: showLabels && label != null
              ? _getLabeledItem(theme)
              : _getThemedIcon(theme),
        ),
      ),
    );
  }

  Widget _getLabeledItem(SnakeBarThemeData theme) {
    return Column(
      spacing: 1,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getThemedIcon(theme),
        _getThemedTitle(theme),
      ],
    );
  }

  Widget _getThemedIcon(SnakeBarThemeData theme) {
    final itemGradient =
        isSelected ? theme.selectedItemGradient : theme.unselectedItemGradient;

    final iconWidget = theme.selectionStyle == SelectionStyle.gradient
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: itemGradient.defaultShader,
            child: icon,
          )
        : IconTheme(
            data: IconThemeData(color: itemGradient.colors.first),
            child: icon!,
          );

    return isIndicatorStyle(theme)
        ? Opacity(opacity: isSelected ? 1 : 0.6, child: iconWidget)
        : iconWidget;
  }

  Widget _getThemedTitle(SnakeBarThemeData theme) {
    final textTheme =
        (isSelected ? theme.selectedLabelStyle : theme.unselectedLabelStyle) ??
            const TextStyle();
    final itemGradient =
        isSelected ? theme.selectedItemGradient : theme.unselectedItemGradient;

    final labelWidget = theme.selectionStyle == SelectionStyle.gradient
        ? ShaderMask(
            shaderCallback: itemGradient.defaultShader,
            child: Text(
              label ?? '',
              style: textTheme.copyWith(color: Colors.white),
            ),
          )
        : Text(
            label ?? '',
            style: textTheme.copyWith(color: itemGradient.colors.first),
          );

    return isIndicatorStyle(theme)
        ? Opacity(opacity: isSelected ? 1 : 0.6, child: labelWidget)
        : labelWidget;
  }
}
