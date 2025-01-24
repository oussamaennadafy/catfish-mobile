import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.borderColor,
  });

  final IconData icon;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor ?? AppColors.borderGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Ink(
        child: Icon(
          icon,
          color: Colors.white70,
        ),
      ),
    );
  }
}
