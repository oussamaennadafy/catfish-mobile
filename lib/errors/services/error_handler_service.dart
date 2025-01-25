import 'package:catfish_mobile/errors/bottomsheets/app_error_bottom_sheet.dart';
import 'package:catfish_mobile/shared/widgets/bottomsheets/show_app_modal_bottom_sheet.dart';
import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:catfish_mobile/errors/app_error.dart';

class ErrorHandlerService {
  static void handleError(BuildContext context, dynamic error, [PrimaryButton? primaryButton]) {
    if (AppError.isAppError(error)) {
      _showErrorBottomSheet(context, error, primaryButton);
    } else {
      _showGenericErrorBottomSheet(context);
    }
  }

  static void _showErrorBottomSheet(BuildContext context, AppError error, PrimaryButton? primaryButton) {
    showAppModalBottomSheet(
      context: context,
      child: AppErrorBottomSheet(
        title: error.title,
        description: error.description,
        primaryButton: primaryButton,
      ),
    );
  }

  static void _showGenericErrorBottomSheet(BuildContext context) {
    showAppModalBottomSheet(
      context: context,
      child: AppErrorBottomSheet(),
    );
  }
}
