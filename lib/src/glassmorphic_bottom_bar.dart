import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'glass_nav_item.dart';
import 'glass_nav_style.dart';

/// A modern, customizable dark glassmorphic bottom navigation bar for Flutter.
///
/// Features a frosted glass blur backdrop, smooth tab animations, optional
/// prominent center action button, and customizable dark aesthetic styling.
class DarkGlassmorphicBottomBar extends StatelessWidget {
  /// The list of navigation items. Recommended: 2 to 5 items.
  final List<DarkGlassNavItem> items;

  /// The currently selected item index.
  final int selectedIndex;

  /// Callback fired when an item tab is tapped.
  final ValueChanged<int> onTabSelected;

  /// Optional prominent center action button (e.g. Floating '+' Button).
  /// If provided, this button is centered between the navigation items.
  final DarkGlassActionItem? centerAction;

  /// Styling configuration for the glassmorphic navigation bar.
  final DarkGlassNavStyle style;

  /// Animation duration when switching active states. Default is 250ms.
  final Duration animationDuration;

  /// Animation curve when switching active states. Default is [Curves.easeInOut].
  final Curve animationCurve;

  /// Creates a [DarkGlassmorphicBottomBar].
  const DarkGlassmorphicBottomBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTabSelected,
    this.centerAction,
    this.style = const DarkGlassNavStyle(),
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeInOut,
  }) : assert(items.length >= 2, 'items must have at least 2 items.');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: style.margin,
      child: SafeArea(
        top: false,
        child: Container(
          height: style.height,
          decoration: BoxDecoration(
            borderRadius: style.borderRadius,
            boxShadow: style.shadows ??
                [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
          ),
          child: ClipRRect(
            borderRadius: style.borderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: style.blur,
                sigmaY: style.blur,
              ),
              child: Container(
                padding: style.padding,
                decoration: BoxDecoration(
                  color: style.backgroundColor,
                  borderRadius: style.borderRadius,
                  border: style.border ??
                      Border.all(
                        color: Colors.white.withOpacity(0.12),
                        width: 1.2,
                      ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildChildren(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final List<Widget> children = [];

    if (centerAction == null) {
      for (int i = 0; i < items.length; i++) {
        children.add(_buildItem(i, items[i]));
      }
      return children;
    }

    final mid = items.length ~/ 2;
    for (int i = 0; i < mid; i++) {
      children.add(_buildItem(i, items[i]));
    }

    children.add(_buildCenterAction(centerAction!));

    for (int i = mid; i < items.length; i++) {
      children.add(_buildItem(i, items[i]));
    }

    return children;
  }

  Widget _buildCenterAction(DarkGlassActionItem action) {
    if (action.customWidget != null) {
      return GestureDetector(
        onTap: () {
          if (style.enableHaptics) {
            HapticFeedback.lightImpact();
          }
          action.onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: action.customWidget!,
      );
    }

    final buttonColor = action.color ?? style.activeColor;
    final iconColor = action.iconColor ?? const Color(0xFF10210A);

    return GestureDetector(
      onTap: () {
        if (style.enableHaptics) {
          HapticFeedback.lightImpact();
        }
        action.onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: action.size,
        height: action.size,
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
          boxShadow: action.boxShadow ??
              [
                BoxShadow(
                  color: buttonColor.withOpacity(0.4),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
        ),
        child: Icon(
          action.icon,
          color: iconColor,
          size: action.iconSize,
        ),
      ),
    );
  }

  Widget _buildItem(int index, DarkGlassNavItem item) {
    final isSelected = selectedIndex == index;

    Widget content;
    if (item.customWidget != null) {
      content = item.customWidget!;
    } else {
      content = Icon(
        isSelected ? (item.activeIcon ?? item.icon) : item.icon,
        color: isSelected ? style.activeColor : style.inactiveColor,
        size: 24,
      );
    }

    if (item.badge != null) {
      content = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          content,
          Positioned(
            top: -4,
            right: -6,
            child: item.badge!,
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        if (style.enableHaptics) {
          HapticFeedback.selectionClick();
        }
        onTabSelected(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Tooltip(
        message: item.label ?? '',
        child: AnimatedContainer(
          duration: animationDuration,
          curve: animationCurve,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? style.selectedItemBackgroundColor
                : Colors.transparent,
            border: isSelected
                ? (style.selectedItemBorder ??
                    Border.all(
                      color: style.activeColor.withOpacity(0.25),
                      width: 1.5,
                    ))
                : null,
            borderRadius: style.selectedItemBorderRadius,
          ),
          child: content,
        ),
      ),
    );
  }
}

