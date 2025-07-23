import 'package:flutter/material.dart';

class RgbBorder extends StatefulWidget {
  final Widget child;

  const RgbBorder({super.key, required this.child});

  @override
  State<RgbBorder> createState() => _RgbBorder();
}

class _RgbBorder extends State<RgbBorder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LinearGradient _buildAnimatedGradient(double animationValue) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        const Color(0xFFFF0000),
        const Color(0xFFFF3300),
        const Color(0xFFEF7000),
        const Color(0xFFE2E200),
        const Color(0xFF7ED800),
        const Color(0xFF00FF80),
        const Color(0xFF00DFEF),
        const Color(0xFF4200C7),
        const Color(0xFF6300C3),
        const Color(0xFFEA003A),
      ],
      stops: List.generate(10, (index) => (index / 9 + animationValue) % 10),
      tileMode: TileMode.clamp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: _buildAnimatedGradient(_controller.value),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black,
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
