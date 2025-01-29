import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:catfish_mobile/constants/sizes.dart';
import 'package:catfish_mobile/shared/widgets/avatars/name_avatar.dart';
import 'package:catfish_mobile/shared/widgets/shadows/illustration_shadow.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CallFrame extends StatefulWidget {
  const CallFrame({
    super.key,
    this.cameraController,
    this.loading,
    this.cameraOpen = true,
    required this.isCollapsed,
    this.cameraAspectRatio,
    required this.frameHeight,
    required this.frameWidth,
  });

  final CameraController? cameraController;
  final bool? loading;
  final bool? cameraOpen;
  final bool isCollapsed;
  final double? cameraAspectRatio;
  final double frameHeight;
  final double frameWidth;

  @override
  State<CallFrame> createState() => _CallFrameState();
}

class _CallFrameState extends State<CallFrame> with TickerProviderStateMixin {
  late AnimationController traslateXanimationController;
  late AnimationController traslateYanimationController;

  late double collapsedFrameHeigth;

  @override
  void initState() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;
    collapsedFrameHeigth = (COLLAPSED_CALL_PREVIEW_WIDTH * (widget.cameraAspectRatio != null ? widget.cameraAspectRatio! : 1.7));
    traslateXanimationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: size.width - (12 * 2) - (10 * 2) - (COLLAPSED_CALL_PREVIEW_WIDTH + 1),
      value: 0,
      duration: Duration(milliseconds: 1000),
    );
    traslateYanimationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: widget.frameHeight - collapsedFrameHeigth - 20,
      value: 0,
      duration: Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showCameraPreview = widget.cameraController != null && widget.cameraController!.value.isInitialized && widget.cameraOpen == true;
    Widget? content = Stack(
      alignment: Alignment.center,
      children: [
        IllustrationShadow(
          alpha: 0.2,
          size: widget.isCollapsed == true ? 50 : 150,
          blurRadius: widget.isCollapsed ? 20 : 80,
        ),
        NameAvatar(
          size: widget.isCollapsed == true ? NameAvatarSize.small : NameAvatarSize.large,
        ),
      ],
    );
    if (widget.loading == true) {
      content = Center(child: SizedBox(height: widget.isCollapsed == true ? 10 : null, width: widget.isCollapsed == true ? 10 : null, child: CircularProgressIndicator(strokeWidth: widget.isCollapsed == true ? 1.0 : 4.0)));
    } else if (widget.cameraController != null && widget.cameraOpen == true) {
      content = CameraPreview(
        widget.cameraController!,
      );
    }
    return Center(
      child: GestureDetector(
        onTap: () {},
        onPanUpdate: (details) {
          if (widget.isCollapsed) {
            traslateXanimationController.value -= details.delta.dx;
            traslateYanimationController.value += details.delta.dy;
          }
        },
        onPanEnd: (details) {
          double traslateXOfCenterOfCollapsed = traslateXanimationController.value + 10 + (COLLAPSED_CALL_PREVIEW_WIDTH / 2);
          double traslateYOfCenterOfCollapsed = traslateYanimationController.value + 10 + collapsedFrameHeigth / 2;
          double xCenter = widget.frameWidth / 2;
          double yCenter = widget.frameHeight / 2;
          if (xCenter >= traslateXOfCenterOfCollapsed && yCenter >= traslateYOfCenterOfCollapsed) {
            traslateXanimationController.animateTo(0);
            traslateYanimationController.animateTo(0);
          } else if (xCenter < traslateXOfCenterOfCollapsed && yCenter >= traslateYOfCenterOfCollapsed) {
            traslateXanimationController.forward();
            traslateYanimationController.animateTo(0);
          } else if (xCenter > traslateXOfCenterOfCollapsed && yCenter < traslateYOfCenterOfCollapsed) {
            traslateXanimationController.animateTo(0);
            traslateYanimationController.forward();
          } else if (xCenter < traslateXOfCenterOfCollapsed && yCenter < traslateYOfCenterOfCollapsed) {
            traslateXanimationController.forward();
            traslateYanimationController.forward();
          }
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([
            traslateXanimationController,
            traslateYanimationController
          ]),
          builder: (context, child) {
            return Transform.translate(
              offset: widget.isCollapsed ? Offset(-traslateXanimationController.value, traslateYanimationController.value) : Offset(0, 0),
              child: child,
            );
          },
          child: Stack(
            children: [
              Positioned(
                top: widget.isCollapsed == true ? 10 : null,
                right: widget.isCollapsed == true ? 10 : null,
                child: SizedBox(
                  height: widget.isCollapsed == true ? (widget.cameraAspectRatio != null ? COLLAPSED_CALL_PREVIEW_WIDTH * widget.cameraAspectRatio!.toDouble() : (COLLAPSED_CALL_PREVIEW_WIDTH * 1.7)) : null,
                  width: widget.isCollapsed == true ? COLLAPSED_CALL_PREVIEW_WIDTH : null,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVarient,
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
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: showCameraPreview == true ? MainAxisSize.min : MainAxisSize.max,
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
      ),
    );
  }
}
