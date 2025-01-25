import 'package:catfish_mobile/errors/app_error.dart';

class CameraErrors extends AppError {
  CameraErrors({
    required super.code,
    required super.title,
    required super.description,
  });

  static AppError noCameraFound = AppError(
    code: "NoCameraFound",
    title: "No Camera Found",
    description: "we can't find any camera in your device",
  );

  static AppError cameraAccessDenied = AppError(
    code: "CameraAccessDenied",
    title: "Camera Access Denied",
    description: "we cant access your camera, please allow access",
  );
}
