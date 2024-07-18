import 'package:flutter/material.dart';

class AnimatedGradientStar extends StatefulWidget {
  @override
  _AnimatedGradientStarState createState() => _AnimatedGradientStarState();
}

class _AnimatedGradientStarState extends State<AnimatedGradientStar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _colorTween = ColorTween(
      begin: Colors.pink,
      end: Colors.yellow,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [_colorTween.value!, Colors.purple, Colors.blue],
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Image.asset(
        'assets/images/ai_star.png',
        color: Colors.white,
        height: 30,
        width: 30,
      ),
    );
  }
}
