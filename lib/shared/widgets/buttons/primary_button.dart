import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    this.onPress,
    this.height,
    this.padding,
    this.margin,
  });

  final String text;
  final IconData? icon;
  final void Function()? onPress;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  // IMPORTANT: update it each time you modify the class
  PrimaryButton copyWith({
    final String? text,
    final IconData? icon,
    final void Function()? onPress,
    final double? height,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
  }) {
    return PrimaryButton(
      text: text ?? this.text,
      height: height ?? this.height,
      icon: icon ?? this.icon,
      onPress: onPress ?? this.onPress,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
        margin: margin,
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
