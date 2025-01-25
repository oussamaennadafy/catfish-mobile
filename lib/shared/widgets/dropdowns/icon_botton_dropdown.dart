import 'package:catfish_mobile/features/callHub/enums/room_types.dart';
import 'package:catfish_mobile/features/callHub/models/room_type_button.dart';
import 'package:catfish_mobile/shared/widgets/buttons/icon_button.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IconBottonDropdown extends StatelessWidget {
  const IconBottonDropdown({
    super.key,
    required this.buttonsList,
    required this.selectedButton,
  });

  final List<RoomTypeButton> buttonsList;
  final RoomType selectedButton;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: Icons.person,
      backgroundColor: AppColors.surfaceVarient,
    );
  }
}
