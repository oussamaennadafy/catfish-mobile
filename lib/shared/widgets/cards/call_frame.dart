import 'package:camera/camera.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CallFrame extends StatelessWidget {
  const CallFrame({
    super.key,
    this.cameraController,
  });

  final CameraController? cameraController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: cameraController == null ? 1 : 0,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderGrey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Container(
          // padding: EdgeInsets.all(1.0),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Center(
            child: cameraController != null
                ? CameraPreview(
                    cameraController!,
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
