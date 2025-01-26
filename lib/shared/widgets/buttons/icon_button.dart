import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.id,
    required this.icon,
    this.backgroundColor,
    this.borderColor,
    this.onPress,
    this.activeBackgroundColor,
    this.active = false,
  });

  final String? id;
  final bool? active;
  final IconData icon;
  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final Color? borderColor;
  final void Function()? onPress;

  // IMPORTANT: update it each time you modify the class
  AppIconButton copyWith({
    String? id,
    bool? active,
    IconData? icon,
    Color? backgroundColor,
    Color? activeBackgroundColor,
    Color? borderColor,
    void Function()? onPress,
  }) {
    return AppIconButton(
      id: id ?? this.id,
      active: active ?? this.active,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBackgroundColor: activeBackgroundColor ?? this.activeBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      onPress: onPress ?? this.onPress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: active == true ? activeBackgroundColor : backgroundColor,
        border: Border.all(
          color: borderColor ?? AppColors.borderGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: InkWell(
        highlightColor: backgroundColor,
        overlayColor: WidgetStateProperty.all(backgroundColor),
        onTap: onPress,
        child: Icon(
          icon,
          color: Colors.white70,
        ),
      ),
    );
  }
}
