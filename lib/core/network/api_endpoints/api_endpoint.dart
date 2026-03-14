class ApiEndpoint {
  ApiEndpoint._internal();
  static const String baseEndpoint =
      "http://00.00.000.000:8080/api/v1"; // Place you api end-point here.

  static String sample = "/sample-endpoint";
  static String sampleById(String id) => "/sample-endpoint/$id";
}
