import 'package:camera/camera.dart';
import 'package:catfish_mobile/errors/camera_errors.dart';
import 'package:catfish_mobile/errors/services/error_handler_service.dart';
import 'package:catfish_mobile/features/callHub/widgets/actions_bar.dart';
import 'package:catfish_mobile/features/callHub/widgets/header/index.dart';
import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:catfish_mobile/shared/widgets/cards/call_frame.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CallHub extends StatefulWidget {
  const CallHub({super.key});

  @override
  State<CallHub> createState() => _CallHubState();
}

class _CallHubState extends State<CallHub> with WidgetsBindingObserver {
  CameraController? controller;
  bool camerPreviewLoader = false;
  bool cameraOpen = true;
  bool micOpen = true;
  String? error;

  Future<void> _initializeCameraController() async {
    setState(() {
      camerPreviewLoader = true;
    });
    try {
      final camerasList = await availableCameras();

      // check if not camera found
      if (camerasList.isEmpty) {
        throw CameraErrors.noCameraFound;
      }

      controller = CameraController(camerasList[1], ResolutionPreset.ultraHigh, enableAudio: true);

      // initialize camera
      await controller!.initialize();
    } catch (e) {
      if (!mounted) return;
      print(e);
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
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCameraController();
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
      _initializeCameraController();
    }
  }

  void handleCameraToggle() async {
    if (controller == null) {
      _initializeCameraController();
      return;
    }

    if (!controller!.value.isInitialized) {
      _initializeCameraController();
    } else {
      setState(() {
        cameraOpen = !cameraOpen;
      });
    }
  }

  void handleMicToggle() async {
    setState(() {
      micOpen = !micOpen;
    });
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
            // CallFrame(),
            // SizedBox(height: 8.0),
            CallFrame(
              cameraController: controller,
              loading: camerPreviewLoader,
              cameraOpen: cameraOpen,
            ),
            SizedBox(height: 16.0),
            ActionsBar(
              handleCameraToggle: handleCameraToggle,
              handleMicToggle: handleMicToggle,
              cameraBottonActive: !(controller != null && controller!.value.isInitialized && cameraOpen),
              micBottonActive: !micOpen,
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
