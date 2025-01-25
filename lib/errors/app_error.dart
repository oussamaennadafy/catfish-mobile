class AppError implements Exception {
  AppError({
    required this.code,
    required this.title,
    required this.description,
  });

  static bool isAppError(dynamic err) {
    return err is AppError;
  }

  final String code;
  final String title;
  final String description;
}
