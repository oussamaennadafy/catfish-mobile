import 'package:camera/camera.dart';
import 'package:catfish_mobile/errors/camera_errors.dart';
import 'package:catfish_mobile/errors/services/error_handler_service.dart';
import 'package:catfish_mobile/features/callHub/enums/room_types.dart';
import 'package:catfish_mobile/features/callHub/models/room_type_button.dart';
import 'package:catfish_mobile/features/callHub/widgets/actions_bar.dart';
import 'package:catfish_mobile/features/callHub/widgets/header/index.dart';
import 'package:catfish_mobile/routes/constants/app_screens.dart';
import 'package:catfish_mobile/shared/widgets/buttons/icon_button.dart';
import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:catfish_mobile/shared/widgets/cards/call_frame.dart';
import 'package:catfish_mobile/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class CallHub extends StatefulWidget {
  const CallHub({super.key});

  @override
  State<CallHub> createState() => _CallHubState();
}

class _CallHubState extends State<CallHub> with WidgetsBindingObserver {
  CameraController? controller;
  bool camerPreviewLoader = false;
  bool cameraOpen = false;
  bool micOpen = false;
  RoomType seletedRoomType = RoomType.twoPeople;
  String? error;
  late List<RoomTypeButton> roomTypeButtons;
  bool isRoomStarted = false;
  double? cameraAspectRatio;

  Future<void> _initializeCameraController() async {
    setState(() {
      camerPreviewLoader = true;
      cameraOpen = false;
    });
    try {
      final camerasList = await availableCameras();

      // check if not camera found
      if (camerasList.isEmpty) {
        throw CameraErrors.noCameraFound;
      }

      controller = CameraController(camerasList[1], ResolutionPreset.high, enableAudio: true);

      // initialize camera
      await controller!.initialize();

      if (controller != null) {
        final isInitialized = controller!.value.isInitialized;
        if (isInitialized) cameraAspectRatio ??= controller!.value.aspectRatio;
      }
    } catch (e) {
      if (!mounted) return;
      if (e is CameraException && e.code == "CameraAccessDenied") {
        ErrorHandlerService.handleError(
          context,
          CameraErrors.cameraAccessDenied,
          PrimaryButton(
            text: "go to setting",
            onPress: () async {
              await openAppSettings();
            },
          ),
        );
        return;
      }
      ErrorHandlerService.handleError(context, e);
    } finally {
      setState(() {
        camerPreviewLoader = false;
        cameraOpen = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeRoomTypeButtons();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraOpen) _initializeCameraController();
    }
  }

  void initializeRoomTypeButtons() {
    roomTypeButtons = [
      RoomTypeButton(
        roomType: RoomType.fourPeople,
        typeButton: AppIconButton(
          icon: Icons.groups,
          backgroundColor: AppColors.surfaceVarient,
          activeBackgroundColor: AppColors.lightSurface,
          onPress: () {
            setState(() {
              seletedRoomType = RoomType.fourPeople;
            });
          },
        ),
      ),
      RoomTypeButton(
        roomType: RoomType.threePeople,
        typeButton: AppIconButton(
          icon: Icons.group,
          backgroundColor: AppColors.surfaceVarient,
          activeBackgroundColor: AppColors.lightSurface,
          onPress: () {
            setState(() {
              seletedRoomType = RoomType.threePeople;
            });
          },
        ),
      ),
      RoomTypeButton(
        roomType: RoomType.twoPeople,
        typeButton: AppIconButton(
          icon: Icons.person,
          backgroundColor: AppColors.surfaceVarient,
          activeBackgroundColor: AppColors.lightSurface,
          onPress: () {
            setState(() {
              seletedRoomType = RoomType.twoPeople;
            });
          },
        ),
      ),
    ];
  }

  void handleCameraToggle() async {
    if (controller == null) {
      _initializeCameraController();
      return;
    }

    if (!controller!.value.isInitialized) {
      _initializeCameraController();
    } else {
      if (controller == null) return;
      if (cameraOpen) {
        await controller!.dispose();
        setState(() {
          cameraOpen = false;
        });
      } else {
        await _initializeCameraController();
        setState(() {
          cameraOpen = true;
        });
      }
    }
  }

  void handleMicToggle() async {
    setState(() {
      micOpen = !micOpen;
    });
  }

  void handleSkipButton() async {
    // emit search event depending on room type
    // if (isRoomStarted == false) {
    setState(() {
      isRoomStarted = !isRoomStarted;
    });
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        child: Column(
          children: [
            Header(),
            SizedBox(height: 8.0),
            CallFrame(
              cameraController: controller,
              loading: camerPreviewLoader,
              cameraOpen: cameraOpen,
              isCollapsed: isRoomStarted,
              cameraAspectRatio: cameraAspectRatio,
            ),
            SizedBox(height: 16.0),
            ActionsBar(
              handleCameraToggle: handleCameraToggle,
              handleMicToggle: handleMicToggle,
              cameraBottonActive: !(controller != null && controller!.value.isInitialized && cameraOpen),
              micBottonActive: !micOpen,
              roomTypeButtons: roomTypeButtons,
              selectedRoomType: seletedRoomType,
              handleSkipButton: handleSkipButton,
              isRoomStarted: isRoomStarted,
              handleLeaveHub: () {
                context.go(AppScreens.onBoarding);
              },
            ),
            // SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
