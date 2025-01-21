import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.icon,
    this.onPress,
  });

  final String text;
  final IconData? icon;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: icon != null ? 115 : 100,
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 26, 24, 52),
          borderRadius: BorderRadius.all(
            Radius.circular(9999),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(-0.2, -1),
              color: Color.fromARGB(255, 135, 131, 190),
              spreadRadius: 1,
              blurRadius: 50,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null) Icon(icon)
          ],
        ),
      ),
    );
  }
}
