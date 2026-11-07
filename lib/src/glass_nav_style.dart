import 'package:flutter/material.dart';

/// Styling configuration for [DarkGlassmorphicBottomBar].
class DarkGlassNavStyle {
  /// The blur intensity for the glassmorphic effect. Default is 16.0.
  final double blur;

  /// The background color tint with opacity. Default is dark translucent (0xFF111713 with opacity 0.75).
  final Color backgroundColor;

  /// The border of the glass pill.
  final BoxBorder? border;

  /// Border radius of the glass container. Default is 36.0.
  final BorderRadius borderRadius;

  /// Active item icon and highlight color. Default is neon lime (0xFF86E829).
  final Color activeColor;

  /// Inactive item icon color. Default is Colors.white70.
  final Color inactiveColor;

  /// Background color of the selected item indicator box.
  final Color selectedItemBackgroundColor;

  /// Border of the selected item indicator box.
  final BoxBorder? selectedItemBorder;

  /// Corner radius of the selected item indicator box. Default is 14.0.
  final BorderRadius selectedItemBorderRadius;

  /// Height of the navigation bar. Default is 68.0.
  final double height;

  /// Margin around the navigation bar. Default is EdgeInsets.symmetric(horizontal: 20, vertical: 20).
  final EdgeInsetsGeometry margin;

  /// Padding inside the navigation bar. Default is EdgeInsets.symmetric(horizontal: 16).
  final EdgeInsetsGeometry padding;

  /// Drop shadows for the entire glass container.
  final List<BoxShadow>? shadows;

  /// Whether to trigger haptic feedback on tab changes. Default is true.
  final bool enableHaptics;

  /// Creates a [DarkGlassNavStyle].
  const DarkGlassNavStyle({
    this.blur = 16.0,
    this.backgroundColor = const Color(0xB8111713),
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(36.0)),
    this.activeColor = const Color(0xFF86E829),
    this.inactiveColor = Colors.white70,
    this.selectedItemBackgroundColor = const Color(0xFF1B261D),
    this.selectedItemBorder,
    this.selectedItemBorderRadius = const BorderRadius.all(Radius.circular(14.0)),
    this.height = 68.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.shadows,
    this.enableHaptics = true,
  });
}

