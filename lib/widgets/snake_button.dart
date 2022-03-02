import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class SnakeButton extends StatefulWidget {
  const SnakeButton(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.snakeColor = Colors.purple,
      this.borderColor = Colors.white,
      this.borderWidth = 4.0,
      this.onTap})
      : super(key: key);

  final Widget child;
  final Duration? duration;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  @override
  _SnakeButtonState createState() => _SnakeButtonState();
}

class _SnakeButtonState extends State<SnakeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ??
          const Duration(
            milliseconds: 1500,
          ),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: _SnakePainter(
          animation: _controller,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
          snakeColor: widget.snakeColor,
        ),
        child: Container(
          height: 100,
          width: 250,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _SnakePainter extends CustomPainter {
  final Animation animation;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;
  final Color secondSnakeColor;

  _SnakePainter(
      {this.snakeColor = Colors.purple,
      this.borderColor = Colors.white,
      this.borderWidth = 4.0,
      required this.animation,
      this.secondSnakeColor = Colors.transparent})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [snakeColor, Colors.transparent],
        stops: [0.7, 1.0],
        startAngle: 0.0,
        endAngle: vector.radians(90),
        transform: GradientRotation(vector.radians(360.0 * animation.value)),
      ).createShader(rect);

    final path = Path.combine(PathOperation.xor, Path()..addRect(rect),
        Path()..addRect(rect.deflate(borderWidth)));
    canvas.drawRect(
      rect.deflate(borderWidth / 2),
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
