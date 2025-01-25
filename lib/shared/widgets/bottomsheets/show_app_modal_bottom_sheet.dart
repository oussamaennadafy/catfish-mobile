import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

void showAppModalBottomSheet({
  required BuildContext context,
  required Widget child,
  Color? backgroundColor,
  bool hasMargin = false,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor ?? AppColors.surface,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (context) {
      return child;
    },
  );
}
