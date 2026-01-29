import 'dart:convert';

import 'package:b_potash/core/exported_files/exported_file.dart';

class ApiService extends GetxService {
  final ApiClient _client = Get.find<ApiClient>();

  Future<ResponseData> getData({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _client.getData(
        url: url,
        headers: headers,
        query: query,
      );

      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<ResponseData> postData({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.postData(
        url: url,
        body: body,
        headers: headers,
      );

      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<ResponseData> postMultipart({
    required String url,
    required FormData formData,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.postMultipart(
        url: url,
        formData: formData,
        headers: headers,
      );
      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<ResponseData> putMultipart({
    required String url,
    required FormData formData,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.putMultipart(
        url: url,
        formData: formData,
        headers: headers,
      );
      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<ResponseData> patchMultipart({
    required String url,
    required FormData formData,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.patchMultipart(
        url: url,
        formData: formData,
        headers: headers,
      );
      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<ResponseData> putData({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.putData(
        url: url,
        body: body,
        headers: headers,
      );
      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<ResponseData> patchData({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.patchData(
        url: url,
        body: body,
        headers: headers,
      );
      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<ResponseData> deleteData({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.deleteData(url: url, headers: headers);
      return _decodeAndHandle(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  ResponseData _decodeAndHandle(Response response) {
    dynamic decoded;

    if (response.body is Map || response.body is List) {
      decoded = response.body;
    } else if (response.body is String) {
      try {
        decoded = jsonDecode(response.body);
      } catch (e) {
        DService().error("Failed to decode response: $e");
        decoded = <String, dynamic>{};
      }
    } else {
      decoded = <String, dynamic>{};
    }

    if (decoded is List) {
      decoded = <String, dynamic>{'success': true, 'data': decoded};
    }

    return _handleBackendError(decoded, response.statusCode);
  }

  ResponseData _handleBackendError(dynamic body, int? statusCode) {
    body ??= {};

    if (body is Map<String, dynamic>) {
      // Handle explicit success: false
      if (body.containsKey("success") && body["success"] == false) {
        final msg = body["message"] ?? "Operation failed";
        _showError(msg);

        final backendError = BackendErrorResponse(
          message: msg,
          statusCode: statusCode,
          details: body,
        );
        DService().warning("$backendError");

        return ResponseData.error(
          message: msg,
          statusCode: statusCode,
          data: body,
          errorDetails: body,
        );
      }

      // Handle "error" field
      if (body.containsKey("error")) {
        final msg = body["error"] ?? "Unknown backend error";
        _showError(msg);

        return ResponseData.error(
          message: msg,
          statusCode: statusCode,
          data: body,
          errorDetails: body,
        );
      }

      // Handle validation "errors" field
      if (body.containsKey("errors") && body["errors"] is Map) {
        final errors = body["errors"] as Map;
        final msg = errors.values.map((e) => e.toString()).join("\n");
        _showError(msg);

        final backendError = BackendErrorResponse(
          message: msg,
          statusCode: statusCode,
          details: body,
        );
        DService().warning("$backendError");

        return ResponseData.error(
          message: msg,
          statusCode: statusCode,
          data: body,
          errorDetails: body["errors"],
        );
      }

      // Success case - check HTTP status code
      if (statusCode != null && statusCode >= 200 && statusCode < 300) {
        return ResponseData.success(
          data: body,
          message: body["message"],
          statusCode: statusCode,
        );
      }

      // Default success case (when backend returns success: true or valid data)
      if (body.containsKey("success") && body["success"] == true) {
        return ResponseData.success(
          data: body,
          message: body["message"],
          statusCode: statusCode,
        );
      }

      // Other error cases
      final msg = body["message"] ?? "Unknown error";
      _showError(msg);

      return ResponseData.error(
        message: msg,
        statusCode: statusCode,
        data: body,
        errorDetails: body,
      );
    }

    if (body is List) {
      return ResponseData.success(data: body, statusCode: statusCode);
    }

    const msg = "Unexpected response format";
    _showError(msg);

    final backendError = BackendErrorResponse(
      message: msg,
      statusCode: statusCode,
      details: body,
    );
    DService().warning("$backendError");

    return ResponseData.error(message: msg, statusCode: statusCode, data: body);
  }

  void _showError(String message) {
    if (message.isNotEmpty) {
      CustomLoader.dismiss();
      MessageHelper().showWarning(title: "Error", message: message);
    }
  }

  ResponseData _handleException(dynamic exception) {
    String errorMessage;

    if (exception is Exception) {
      errorMessage = exception.toString().replaceFirst('Exception: ', '');
    } else {
      errorMessage = exception.toString();
    }

    DService().error("API Service caught exception: $errorMessage");
    DService().error("Exception type: ${exception.runtimeType}");

    // Return a consistent error response format
    // Note: Error message is already shown by ApiClient, so we don't show it again here
    return ResponseData.error(
      message: errorMessage,
      errorDetails: exception.toString(),
    );
  }
}
