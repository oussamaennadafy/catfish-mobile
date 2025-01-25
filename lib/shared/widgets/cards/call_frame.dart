import 'package:camera/camera.dart';
import 'package:catfish_mobile/shared/widgets/avatars/name_avatar.dart';
import 'package:catfish_mobile/shared/widgets/shadows/illustration_shadow.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CallFrame extends StatelessWidget {
  const CallFrame({
    super.key,
    this.cameraController,
    this.loading,
    this.cameraOpen = true,
  });

  final CameraController? cameraController;
  final bool? loading;
  final bool? cameraOpen;

  @override
  Widget build(BuildContext context) {
    final showCameraPreview = cameraController != null && cameraController!.value.isInitialized && cameraOpen == true;
    Widget? content = Stack(
      alignment: Alignment.center,
      children: [
        IllustrationShadow(alpha: 0.2),
        NameAvatar(),
      ],
    );
    if (loading == true) {
      content = Center(child: CircularProgressIndicator());
    } else if (cameraController != null && cameraOpen == true) {
      content = CameraPreview(
        cameraController!,
      );
    }
    return Expanded(
      flex: 1,
      child: Center(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.surfaceVarient.withValues(alpha: 0.5),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: showCameraPreview == true ? MainAxisSize.min : MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
