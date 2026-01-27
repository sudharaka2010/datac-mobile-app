// lib/widgets/glass_card.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double radius;
  final EdgeInsets padding;

  /// Pass exact RGBA you want from screen
  final Color glassColor;   // already includes opacity if you pass withValues(alpha:..)
  final Color borderColor;  // already includes opacity if you pass withValues(alpha:..)

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 12,
    this.radius = 20,
    this.padding = const EdgeInsets.all(18),
    required this.glassColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
