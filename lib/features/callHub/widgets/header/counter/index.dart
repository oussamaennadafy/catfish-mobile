import 'package:catfish_mobile/features/callHub/widgets/header/counter/timer_text.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: Border.all(
          color: AppColors.borderGrey,
          width: 1,
        ),
      ),
      child: Row(
        spacing: 8.0,
        children: [
          Icon(
            Icons.schedule,
            color: Colors.white70,
          ),
          TimerText(),
        ],
      ),
    );
  }
}
