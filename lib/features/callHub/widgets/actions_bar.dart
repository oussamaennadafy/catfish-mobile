import 'package:catfish_mobile/shared/widgets/buttons/icon_button.dart';
import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionsBar extends StatelessWidget {
  const ActionsBar({
    super.key,
    required this.handleCameraToggle,
    required this.cameraBottonActive,
    required this.handleMicToggle,
    required this.micBottonActive,
  });

  final bool cameraBottonActive;
  final bool micBottonActive;
  final void Function() handleCameraToggle;
  final void Function() handleMicToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 4.0,
          children: [
            Transform.flip(
              flipX: true,
              child: AppIconButton(
                icon: Icons.logout,
                backgroundColor: Colors.red.withValues(alpha: 0.8),
                borderColor: Colors.red.withValues(alpha: 0.8),
              ),
            ),
            AppIconButton(
              icon: Icons.people,
              backgroundColor: AppColors.surfaceVarient,
            ),
            AppIconButton(
              icon: Icons.mic_off_outlined,
              backgroundColor: AppColors.surfaceVarient,
              onPress: handleMicToggle,
              active: micBottonActive,
              activeBackgroundColor: AppColors.lightSurface,
            ),
            AppIconButton(
              icon: Icons.videocam_off_sharp,
              backgroundColor: AppColors.surfaceVarient,
              activeBackgroundColor: AppColors.lightSurface,
              onPress: handleCameraToggle,
              active: cameraBottonActive,
            ),
          ],
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: PrimaryButton(
            text: "Switch User",
            icon: Icons.shuffle_rounded,
            onPress: () {
              final width = MediaQuery.of(context).size.width;
              final height = MediaQuery.of(context).size.height;
              print({
                "width": width.toString(),
                "height": height.toString(),
                "aspectRatio": width / height,
              });
            },
          ),
        ),
      ],
    );
  }
}
