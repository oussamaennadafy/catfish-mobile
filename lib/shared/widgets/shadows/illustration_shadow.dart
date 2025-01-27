import 'package:flutter/material.dart';

class IllustrationShadow extends StatelessWidget {
  const IllustrationShadow({
    super.key,
    this.alpha,
    this.size,
    this.blurRadius,
  });

  final double? alpha;
  final double? size;
  final double? blurRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 150,
      height: size ?? 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: alpha ?? 0.1),
            blurRadius: blurRadius ?? 80,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            9999,
          ),
        ),
      ),
    );
  }
}
