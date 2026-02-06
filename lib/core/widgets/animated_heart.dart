import 'package:flutter/material.dart';

class AnimatedHeart extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onTap;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const AnimatedHeart({
    super.key,
    required this.isFavorite,
    required this.onTap,
    this.size = 24,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _showParticles = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap();
    if (!widget.isFavorite) {
      setState(() => _showParticles = true);
      _controller.forward(from: 0).then((_) {
        if (mounted) setState(() => _showParticles = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: widget.size + 20,
        height: widget.size + 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Particle Effects
            if (_showParticles) ..._buildParticles(),
            // Heart Icon
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: widget.isFavorite ? _scaleAnimation.value : 1.0,
                  child: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: widget.size,
                    color: widget.isFavorite
                        ? widget.activeColor
                        : widget.inactiveColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildParticles() {
    return List.generate(6, (index) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final progress = _controller.value;
          final distance = progress * 20;
          return Transform.translate(
            offset: Offset(
              distance *
                  1.5 *
                  (index.isEven ? 1 : -1) *
                  (index % 3 == 0 ? 0.5 : 1),
              distance * (index < 3 ? -1 : 1),
            ),
            child: Opacity(
              opacity: 1 - progress,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: widget.activeColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
