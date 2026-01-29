/// Standardized response wrapper for all API calls
/// Provides type-safe access to response data and status
class ResponseData {
  /// Indicates if the API call was successful
  final bool isSuccess;

  /// Optional message from the backend (error or success message)
  final String? message;

  /// The actual response data (can be Map, List, or any type)
  final dynamic data;

  /// HTTP status code
  final int? statusCode;

  /// Additional error details for debugging
  final dynamic errorDetails;

  ResponseData({
    required this.isSuccess,
    this.message,
    this.data,
    this.statusCode,
    this.errorDetails,
  });

  /// Factory constructor for success responses
  factory ResponseData.success({
    dynamic data,
    String? message,
    int? statusCode,
  }) {
    return ResponseData(
      isSuccess: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  /// Factory constructor for error responses
  factory ResponseData.error({
    required String message,
    dynamic data,
    int? statusCode,
    dynamic errorDetails,
  }) {
    return ResponseData(
      isSuccess: false,
      message: message,
      data: data,
      statusCode: statusCode,
      errorDetails: errorDetails,
    );
  }

  /// Convenience getter to check if response failed
  bool get isFailure => !isSuccess;

  @override
  String toString() {
    return 'ResponseData(isSuccess: $isSuccess, message: $message, statusCode: $statusCode)';
  }
}
