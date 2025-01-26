import 'package:catfish_mobile/features/callHub/enums/room_types.dart';
import 'package:catfish_mobile/features/callHub/models/room_type_button.dart';
import 'package:catfish_mobile/shared/widgets/buttons/icon_button.dart';
import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:catfish_mobile/shared/widgets/dropdowns/icon_botton_dropdown.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionsBar extends StatelessWidget {
  const ActionsBar({
    super.key,
    required this.handleCameraToggle,
    required this.cameraBottonActive,
    required this.handleMicToggle,
    required this.micBottonActive,
    required this.handleLeaveHub,
    required this.roomTypeButtons,
    required this.selectedRoomType,
    required this.handleSkipButton,
    required this.isRoomStarted,
  });

  final bool cameraBottonActive;
  final bool micBottonActive;
  final void Function() handleCameraToggle;
  final void Function() handleMicToggle;
  final void Function() handleLeaveHub;
  final void Function() handleSkipButton;
  final List<RoomTypeButton> roomTypeButtons;
  final RoomType selectedRoomType;
  final bool isRoomStarted;

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
                onPress: handleLeaveHub,
              ),
            ),
            IconBottonDropdown(
              buttonsList: roomTypeButtons,
              selectedButtonType: selectedRoomType,
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
            text: isRoomStarted ? "Switch User" : "Start call",
            icon: isRoomStarted ? Icons.shuffle_rounded : Icons.east,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            onPress: handleSkipButton,
          ),
        ),
      ],
    );
  }
}
