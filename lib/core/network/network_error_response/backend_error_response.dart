class BackendErrorResponse implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? details;

  BackendErrorResponse({
    required this.message,
    this.statusCode,
    this.details,
  });

  @override
  String toString() {
    return 'BackendError(statusCode: $statusCode, message: $message, details: $details)';
  }
}
