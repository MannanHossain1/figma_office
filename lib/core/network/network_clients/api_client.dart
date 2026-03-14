import 'dart:async';
import 'dart:io';

import 'package:flutter_codebase/core/exported_files/exported_file.dart';

class ApiClient extends GetConnect {
  final AppService _appService = Get.find<AppService>();

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  @override
  void onInit() {
    httpClient.baseUrl = ApiEndpoint.baseEndpoint;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.defaultContentType = "application/json; charset=utf-8";
    httpClient.maxAuthRetries = 1;

    httpClient.addRequestModifier<void>((request) async {
      final String? token = _appService.accessToken.value;
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    super.onInit();
  }

  Future<Response> _executeRequest(
    Future<Response> Function() requestFunc,
  ) async {
    try {
      final response = await requestFunc();
      _logResponse(response);

      // Check for null status code before processing
      if (response.statusCode == null) {
        const msg = "No response from server.";
        DService().error("API Request failed: $msg");
        DService().error("Request URL: ${response.request?.url ?? 'Unknown'}");
        _showError(msg);
        throw Exception(msg);
      }

      if (response.statusCode == 401 &&
          response.body['isAccessTokenExpired'] == true) {
        await _handleTokenRefresh();

        final retryResponse = await requestFunc();
        _logResponse(retryResponse);

        // Check retry response for null status code
        if (retryResponse.statusCode == null) {
          const msg = "No response from server.";
          DService().error("API Retry Request failed: $msg");
          DService().error(
            "Request URL: ${retryResponse.request?.url ?? 'Unknown'}",
          );
          _showError(msg);
          throw Exception(msg);
        }

        return _handleResponseErrors(retryResponse);
      }

      return _handleResponseErrors(response);
    } on SocketException catch (e) {
      const msg = "No internet connection.";
      DService().error("Network error: $msg");
      DService().error("SocketException details: $e");
      _showError(msg);
      rethrow;
    } on TimeoutException catch (e) {
      const msg = "Request timed out. Check your internet.";
      DService().error("Timeout error: $msg");
      DService().error("TimeoutException details: $e");
      _showError(msg);
      rethrow;
    } on HttpException catch (e) {
      final msg = "HTTP error occurred: ${e.message}";
      DService().error("HTTP error: $msg");
      DService().error("HttpException details: $e");
      _showError(msg);
      rethrow;
    } on Exception {
      // Re-throw exceptions that are already handled (like "No response from server")
      rethrow;
    } catch (e) {
      final msg = "Unexpected error: $e";
      DService().error("Unexpected API error: $msg");
      DService().error("Error type: ${e.runtimeType}");
      rethrow;
    }
  }

  Future<void> _handleTokenRefresh() async {
    if (_isRefreshing) {
      await _refreshCompleter?.future;
      return;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();

    // try {
    //   final newToken = await Get.find<RefreshTokenController>().fetchRefreshToken();
    //
    //   if (newToken != null) {
    //     _appService.accessToken.value = newToken;
    //   } else {
    //     await Get.find<LogOutController>().logOut();
    //   }
    // } catch (e) {
    //   DService().error("Token refresh failed: $e");
    //   await Get.find<LogOutController>().logOut();
    // } finally {
    //   _isRefreshing = false;
    //   _refreshCompleter?.complete();
    // }
  }

  Response _handleResponseErrors(Response response) {
    // Note: null statusCode is now handled in _executeRequest before this method is called
    // This method assumes statusCode is not null

    if (response.statusCode! >= 500) {
      final msg =
          response.body['message'] ?? "Server error occurred. Try again later.";
      DService().error("Server error (${response.statusCode}): $msg");
      _showError(msg);
      throw Exception(msg);
    }

    if (response.statusCode == 401) {
      final msg =
          response.body['message'] ?? "Unauthorized. Please log in again.";
      DService().warning("Unauthorized (401): $msg");
      _showError(msg);
      throw Exception(msg);
    }

    return response;
  }

  void _showError(String message) {
    if (message.isNotEmpty) {
      CustomLoader.dismiss();
      MessageHelper().showWarning(title: "Error", message: message);
    }
  }

  void _logResponse(Response response) {
    if (response.isOk) {
      DService().info("API Response Status: ${response.statusCode}");
      DService().info("API Response Body: ${response.body}");
      DService().info("API Endpoint: ${response.request?.url ?? ""}");
    } else {
      DService().warning("API Response Status: ${response.statusCode}");
      DService().warning("API Response Body: ${response.body}");
      DService().warning("API Endpoint: ${response.request?.url ?? ""}");
    }
  }

  Future<Response> getData({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) => _executeRequest(() => get(url, headers: headers, query: query));

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) => _executeRequest(() => post(url, body, headers: headers));

  Future<Response> putData({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) => _executeRequest(() => put(url, body, headers: headers));

  Future<Response> patchData({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) => _executeRequest(() => patch(url, body, headers: headers));

  Future<Response> deleteData({
    required String url,
    Map<String, String>? headers,
  }) => _executeRequest(() => delete(url, headers: headers));

  Future<Response> postMultipart({
    required String url,
    required FormData formData,
    Map<String, String>? headers,
  }) => _executeRequest(
    () => post(
      url,
      formData,
      headers: headers,
      contentType: 'multipart/form-data',
    ),
  );

  Future<Response> putMultipart({
    required String url,
    required FormData formData,
    Map<String, String>? headers,
  }) => _executeRequest(
    () => put(
      url,
      formData,
      headers: headers,
      contentType: 'multipart/form-data',
    ),
  );

  Future<Response> patchMultipart({
    required String url,
    required FormData formData,
    Map<String, String>? headers,
  }) => _executeRequest(
    () => patch(
      url,
      formData,
      headers: headers,
      contentType: 'multipart/form-data',
    ),
  );
}
