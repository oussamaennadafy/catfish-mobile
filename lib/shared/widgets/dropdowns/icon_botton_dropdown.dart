import 'package:catfish_mobile/features/callHub/enums/room_types.dart';
import 'package:catfish_mobile/features/callHub/models/room_type_button.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IconBottonDropdown extends StatefulWidget {
  const IconBottonDropdown({
    super.key,
    required this.buttonsList,
    required this.selectedButtonType,
  });

  final List<RoomTypeButton> buttonsList;
  final RoomType selectedButtonType;

  @override
  State<IconBottonDropdown> createState() => _IconBottonDropdownState();
}

class _IconBottonDropdownState extends State<IconBottonDropdown> with SingleTickerProviderStateMixin {
  final overlayController = OverlayPortalController();
  late RoomTypeButton selectedButton;
  late AnimationController animationController;

  @override
  void initState() {
    selectedButton = widget.buttonsList.where((roomTypeButton) => roomTypeButton.roomType == widget.selectedButtonType).first;
    // find selected button in list from selectedButtonType

    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      value: 1,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IconBottonDropdown oldWidget) {
    if (widget.selectedButtonType != oldWidget.selectedButtonType) {
      selectedButton = widget.buttonsList.where((roomTypeButton) => roomTypeButton.roomType == widget.selectedButtonType).first;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: overlayController,
      overlayChildBuilder: (context) {
        return GestureDetector(
          onTap: () {
            overlayController.hide();
            animationController.value = 1;
          },
          child: Container(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: AnimatedBuilder(
                // animation: animationController,
                animation: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeOut,
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 4.0, left: 12.0 + 45 + 4.0),
                  decoration: BoxDecoration(
                    // color: AppColors.surfaceVarient,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    spacing: 4.0,
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.buttonsList.map(
                      (button) {
                        return button.typeButton.copyWith(
                          onPress: () {
                            if (button.typeButton.onPress != null) button.typeButton.onPress!();
                            overlayController.hide();
                            animationController.value = 1;
                          },
                          active: button.roomType == widget.selectedButtonType,
                        );
                      },
                    ).toList(),
                  ),
                ),
                builder: (context, child) {
                  return Opacity(
                    opacity: 1 - animationController.value,
                    child: Transform.translate(
                      offset: Offset(0, animationController.value * ((widget.buttonsList.length * 45) + (4.0 * (widget.buttonsList.length - 1)) - 45)),
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        height: 45,
        child: selectedButton.typeButton.copyWith(
          onPress: () {
            overlayController.show();
            animationController.animateTo(0, curve: Curves.easeOut);
          },
          active: true,
        ),
      ),
    );
  }
}
