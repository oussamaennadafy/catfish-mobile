import 'package:flutter/material.dart';

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({
    super.key,
    required this.numOfDots,
    this.selectedDot,
  });

  final int numOfDots;
  final int? selectedDot;

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < widget.numOfDots; i++)
          AnimatedContainer(
            width: i == widget.selectedDot ? 50 : 20,
            height: 10,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 26, 24, 52),
              gradient: i == widget.selectedDot
                  ? RadialGradient(
                      center: Alignment(-0.3, -4),
                      radius: 3,
                      colors: [
                        Color.fromARGB(255, 155, 149, 234),
                        Color(0xFF4139B0),
                      ],
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  offset: Offset(-0.2, -1),
                  color: Color.fromARGB(255, 135, 131, 190),
                  spreadRadius: 1,
                  blurRadius: 50,
                  blurStyle: BlurStyle.inner,
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(9999),
              ),
            ),
            duration: Duration(milliseconds: 300),
          )
      ],
    );
  }
}
