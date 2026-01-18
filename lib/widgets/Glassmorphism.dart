import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double borderRadius;
  final double blur;

  const GlassContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.borderRadius = 20.0,
    this.blur = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
