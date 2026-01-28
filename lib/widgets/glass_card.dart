// lib/widgets/glass_card.dart
import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable frosted-glass container used across the app.
/// Designed for dark-glass UI (DATAC style) with iOS blur + Material depth.
///
/// Usage:
/// GlassCard(
///   glassColor: Colors.white.withValues(alpha: 0.10),
///   borderColor: Colors.white.withValues(alpha: 0.14),
///   child: ...
/// )
class GlassCard extends StatelessWidget {
  final Widget child;

  /// Blur strength (higher = more frosted). Keep 10–18 for best results.
  final double blur;

  /// Corner radius for rounded modern cards.
  final double radius;

  /// Inner padding for content.
  final EdgeInsets padding;

  /// Main glass color (usually low-opacity white or deep blue/black tone).
  final Color glassColor;

  /// Border color (usually low-opacity white).
  final Color borderColor;

  /// Adds a subtle depth shadow (Google-like). Turn off for flat UI.
  final bool enableShadow;

  /// Adds a soft inner highlight (iOS-like). Turn off if you want pure flat glass.
  final bool enableHighlight;

  /// Shadow strength (only used if enableShadow is true).
  final double shadowOpacity;

  const GlassCard({
    super.key,
    required this.child,
    required this.glassColor,
    required this.borderColor,
    this.blur = 14,
    this.radius = 20,
    this.padding = const EdgeInsets.all(18),
    this.enableShadow = true,
    this.enableHighlight = true,
    this.shadowOpacity = 0.22,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: glassColor,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: borderColor, width: 1),

              // ✅ Soft elevation for premium look (optional)
              boxShadow: enableShadow
                  ? [
                      BoxShadow(
                        blurRadius: 26,
                        offset: const Offset(0, 12),
                        color: Colors.black.withValues(alpha: shadowOpacity),
                      ),
                    ]
                  : null,
            ),
            child: enableHighlight
                ? _HighlightLayer(child: child)
                : child,
          ),
        ),
      ),
    );
  }
}

/// Adds subtle inner reflection like iOS frosted glass.
/// This makes the card look less "flat" and more premium.
class _HighlightLayer extends StatelessWidget {
  final Widget child;
  const _HighlightLayer({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.06),
            Colors.transparent,
            Colors.black.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: child,
    );
  }
}
