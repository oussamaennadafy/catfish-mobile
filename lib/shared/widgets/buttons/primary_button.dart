import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    this.onPress,
    this.height,
  });

  final String text;
  final IconData? icon;
  final void Function()? onPress;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        height: height ?? 45,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.3, -1),
            radius: 1,
            colors: [
              Color.fromARGB(255, 120, 111, 239),
              Color(0xFF4139B0),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(9999),
          ),
        ),
        child: Row(
          spacing: 4.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (icon != null) SizedBox(width: 12),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
