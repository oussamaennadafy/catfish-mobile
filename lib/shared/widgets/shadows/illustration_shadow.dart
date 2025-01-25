import 'package:flutter/material.dart';

class IllustrationShadow extends StatelessWidget {
  const IllustrationShadow({
    super.key,
    this.alpha,
  });

  final double? alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: alpha ?? 0.1),
            blurRadius: 80,
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
