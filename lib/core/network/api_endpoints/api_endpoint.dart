import 'package:b_potash/core/exported_files/exported_file.dart';

class ApiEndpoint {
  ApiEndpoint._internal();
  static const String baseEndpoint =
      "http://00.00.000.000:8080/api/v1"; // Place you api end-point here.

  static String signUp = "/auth/register";
  static String verifyOPT = "/auth/verify-email";
  static String resendOpt = "/auth/resend-verification-email";
  static String login = "/auth/login";
  static String sample = "/sample-endpoint";
  static String sampleById(String id) => "/sample-endpoint/$id";
}
