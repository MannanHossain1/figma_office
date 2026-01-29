import 'package:b_potash/core/exported_files/exported_file.dart';

class ApiEndpoint {
  ApiEndpoint._internal();

  // static const String baseEndpoint = "http://10.0.20.163:8080/api/v1";
  static const String baseEndpoint =
      "http://23.239.111.164:8080/api/v1"; // live

  // static const String websocketEndpoint = "http://10.0.30.117:5012";

  static String signUp = "/auth/register";
  static String verifyOPT = "/auth/verify-email";
  static String resendOpt = "/auth/resend-verification-email";
  static String login = "/auth/login";
  static String changePass = "/auth/change-password";
  static String myProfile = "/users/me";
  static String updateProfile = "/users/update-profile";
  static String uploadImage = "/assets/upload-multiple";
  static String sendOtp = "/auth/forget-password";
  static String verifyForgetPassword = "/auth/verify-reset-otp";
  static String resetPassword = "/auth/reset-password";

  static String getPoll = "/surveys/polls";
  static String getPollById(String pollId) => "/surveys/polls/$pollId";
  static String getSurvey = "/surveys";
  static String getSurveyById(String surveyId) => "/surveys/$surveyId";
  static String getForum = "/forum-posts";
  static String getForumById(String forumId) => "/forum-posts/$forumId";
  static String likeForumPost(String forumId) => "/forum-posts/$forumId/like";
  static String createForumComment = "/forum-comments";
  static String getForumComments(String postId) => "/forum-comments/$postId";
  static String likeForumComment(String commentId) =>
      "/forum-comments/$commentId/like";
  static String submitResponse = "/responses";
  static String getServiceCenter = "/service-centers/nearby";
  static String getServiceCenterById(String serviceCenterId) =>
      "/service-centers/$serviceCenterId";
  static String rateServiceCenter = "/rate-service-centers";

  static String getService = "/services";
  static String getPolicyConsultant = "/policy-consultations";
  static String getPolicyConsultantById(String policyId) =>
      "/policy-consultations/$policyId";
  static String getPolicyComments(String policyId) =>
      "/policy-consultations/$policyId/comments";
  static String createPolicyComment(String policyId) =>
      "/policy-consultations/$policyId/comments";
  static String likePolicyComment(String commentId) =>
      "/policy-consultations/comments/$commentId/like";
  static String likePolicy(String policyId) =>
      "/policy-consultations/$policyId/like";
  static String getServiceById(String serviceId) => "/services/$serviceId";

  // Booking endpoints
  static String getGovtEntities = "/govt-entities";
  static String getSlots = "/slots";
  static String createBooking = "/bookings";
  static String myBookings = "/bookings/my-bookings";
  static String myBookingById(String bookingId) =>
      "/bookings/my-bookings/$bookingId";

  // unwanted

  static String addCarrierInfo({required String orderId}) =>
      "orders/update-to-in-transit/$orderId";

  static String deleteProduct({required String id}) {
    DService().info("Delete Product ID: $id");
    return "products/$id";
  }

  static String getProducts({
    String? sellerId,
    String? category,
    String? onlyMy,
  }) {
    final queryParams = <String, String>{};

    if (sellerId != null && sellerId.isNotEmpty) {
      queryParams['sellerId'] = sellerId;
    }

    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    if (onlyMy != null && onlyMy.isNotEmpty) {
      queryParams['onlyMy'] = onlyMy;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return 'products?$queryString';
  }

  static String getSearchedProducts({
    String? searchText,
    String? category,
    String? brand,
    String? fromPrice,
    String? toPrice,
    String? condition,
    String? size,
    String? color,
    String? onlyMy,
    String? subcategoryId,
  }) {
    final queryParams = <String, String>{};

    if (searchText != null && searchText.isNotEmpty) {
      queryParams['searchTerm'] = searchText;
    }
    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category.toUpperCase();
    }
    if (brand != null && brand.isNotEmpty) queryParams['brand'] = brand;
    if (fromPrice != null && fromPrice.isNotEmpty) {
      queryParams['fromPrice'] = fromPrice;
    }
    if (toPrice != null && toPrice.isNotEmpty) queryParams['toPrice'] = toPrice;
    if (condition != null && condition.isNotEmpty) {
      queryParams['condition'] = condition.toUpperCase();
    }
    if (size != null && size.isNotEmpty) {
      queryParams['size'] = size.toUpperCase();
    }

    if (subcategoryId != null && subcategoryId.isNotEmpty) {
      queryParams['subcategoryId'] = subcategoryId;
    }

    if (color != null && color.isNotEmpty) queryParams['color'] = color;
    if (onlyMy != null && onlyMy.isNotEmpty) queryParams['onlyMy'] = onlyMy;

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return 'products?$queryString';
  }

  static String getFavoriteSearchedProducts({
    String? searchText,
    String? category,
    String? brand,
    String? fromPrice,
    String? toPrice,
    String? condition,
    String? size,
    String? color,
    String? subcategoryId,
  }) {
    final queryParams = <String, String>{};

    if (searchText != null && searchText.isNotEmpty) {
      queryParams['searchTerm'] = searchText;
    }
    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category.toUpperCase();
    }
    if (brand != null && brand.isNotEmpty) queryParams['brand'] = brand;
    if (fromPrice != null && fromPrice.isNotEmpty) {
      queryParams['fromPrice'] = fromPrice;
    }
    if (toPrice != null && toPrice.isNotEmpty) queryParams['toPrice'] = toPrice;
    if (condition != null && condition.isNotEmpty) {
      queryParams['condition'] = condition.toUpperCase();
    }
    if (size != null && size.isNotEmpty) {
      queryParams['size'] = size.toUpperCase();
    }
    if (subcategoryId != null && subcategoryId.isNotEmpty) {
      queryParams['subcategoryId'] = subcategoryId.toUpperCase();
    }

    if (color != null && color.isNotEmpty) queryParams['color'] = color;

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return 'favorites?$queryString';
  }

  static String getPurchaseProducts({String? deliveryStatus}) {
    final queryParams = <String, String>{};

    if (deliveryStatus != null && deliveryStatus.isNotEmpty) {
      queryParams['deliveryStatus'] = deliveryStatus;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return 'orders/purchases?$queryString';
  }

  static String getSalesProducts({String? deliveryStatus}) {
    final queryParams = <String, String>{};

    if (deliveryStatus != null && deliveryStatus.isNotEmpty) {
      queryParams['deliveryStatus'] = deliveryStatus;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return 'orders/sales?$queryString';
  }

  static String getSubCategory({String? category}) {
    final queryParams = <String, String>{};

    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return 'subcategories?$queryString';
  }
}
