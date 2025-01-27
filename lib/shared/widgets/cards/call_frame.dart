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
    required this.isCollapsed,
    this.cameraAspectRatio,
  });

  final CameraController? cameraController;
  final bool? loading;
  final bool? cameraOpen;
  final bool isCollapsed;
  final double? cameraAspectRatio;

  @override
  Widget build(BuildContext context) {
    print({
      "cameraAspectRatio": cameraAspectRatio
    });
    final showCameraPreview = cameraController != null && cameraController!.value.isInitialized && cameraOpen == true;
    Widget? content = Stack(
      alignment: Alignment.center,
      children: [
        IllustrationShadow(
          alpha: 0.2,
          size: isCollapsed == true ? 50 : 150,
          blurRadius: isCollapsed ? 20 : 80,
        ),
        NameAvatar(
          size: isCollapsed == true ? NameAvatarSize.small : NameAvatarSize.large,
        ),
      ],
    );
    if (loading == true) {
      content = Center(child: SizedBox(height: isCollapsed == true ? 10 : null, width: isCollapsed == true ? 10 : null, child: CircularProgressIndicator(strokeWidth: isCollapsed == true ? 1.0 : 4.0)));
    } else if (cameraController != null && cameraOpen == true) {
      content = CameraPreview(
        cameraController!,
      );
    }
    return Expanded(
      flex: 1,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: isCollapsed == true ? 0 : null,
              right: isCollapsed == true ? 0 : null,
              child: SizedBox(
                height: isCollapsed == true ? (cameraAspectRatio != null ? 80 * cameraAspectRatio!.toDouble() : (80 * 1.7)) : null,
                width: isCollapsed == true ? 80 : null,
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
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        content,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
