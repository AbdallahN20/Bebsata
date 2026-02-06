import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.15,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Single color glassmorphism - uses only white (light) or dark grey (dark)
    final glassColor = isDark ? AppTheme.glassDark : AppTheme.glassLight;

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // Simple single color glass effect
              color: glassColor.withValues(alpha: isDark ? 0.8 : opacity),
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              border: Border.all(
                color: glassColor.withValues(alpha: isDark ? 0.3 : 0.5),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
