import 'package:flutter/material.dart';

/// Represents an item in [DarkGlassmorphicBottomBar].
class DarkGlassNavItem {
  /// The icon displayed when the tab is inactive.
  final IconData icon;

  /// The icon displayed when the tab is active/selected.
  /// If null, [icon] is used.
  final IconData? activeIcon;

  /// Optional label or tooltip for accessibility.
  final String? label;

  /// Optional badge widget displayed on the upper-right corner of the icon.
  final Widget? badge;

  /// Optional custom widget to completely override the default icon rendering.
  final Widget? customWidget;

  /// Creates a [DarkGlassNavItem].
  const DarkGlassNavItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.badge,
    this.customWidget,
  });
}

/// Represents a prominent center action button (e.g. Floating '+' Button).
class DarkGlassActionItem {
  /// The icon inside the action button.
  final IconData icon;

  /// The callback when the action button is pressed.
  final VoidCallback onTap;

  /// The background color of the action button.
  final Color? color;

  /// The icon color inside the action button.
  final Color? iconColor;

  /// The size of the circular action button. Default is 48.
  final double size;

  /// The size of the icon. Default is 28.
  final double iconSize;

  /// Optional box shadow for the button.
  final List<BoxShadow>? boxShadow;

  /// Optional custom child widget.
  final Widget? customWidget;

  /// Creates a [DarkGlassActionItem].
  const DarkGlassActionItem({
    required this.icon,
    required this.onTap,
    this.color,
    this.iconColor,
    this.size = 48.0,
    this.iconSize = 28.0,
    this.boxShadow,
    this.customWidget,
  });
}

