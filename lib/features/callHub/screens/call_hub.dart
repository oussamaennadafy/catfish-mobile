import 'package:camera/camera.dart';
import 'package:catfish_mobile/features/callHub/widgets/actions_bar.dart';
import 'package:catfish_mobile/features/callHub/widgets/header/index.dart';
import 'package:catfish_mobile/shared/widgets/cards/call_frame.dart';
import 'package:flutter/material.dart';

class CallHub extends StatefulWidget {
  const CallHub({super.key});

  @override
  State<CallHub> createState() => _CallHubState();
}

class _CallHubState extends State<CallHub> {
  CameraController? controller;
  String? error;

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {
      if (availableCameras.isEmpty) {
        throw Exception("NoCameraFound");
      }
      controller = CameraController(availableCameras[1], ResolutionPreset.ultraHigh, enableAudio: true);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        print(e);
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    }).catchError((err) {
      print(err.toString());
      setState(() {
        error = err.toString();
      });
    });
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
            ),
            SizedBox(height: 16.0),
            ActionsBar(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
