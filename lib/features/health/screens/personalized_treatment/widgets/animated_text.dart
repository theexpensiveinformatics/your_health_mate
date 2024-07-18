import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle style;

  AnimatedGradientText({required this.text, required this.style});

  @override
  _AnimatedGradientTextState createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _colorTween = ColorTween(
      begin: Color(0xFFFD0E9D),
      end: Color(0xFFAE09FF),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) {
        return Text(
          widget.text,
          style: widget.style.copyWith(
            foreground: Paint()
              ..shader = LinearGradient(
                colors: <Color>[_colorTween.value!, YHMColors.primary.withOpacity(0.8)],
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}