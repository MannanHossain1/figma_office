/// Minimal profile models used by `UserProfileService`.
///
/// Replace/extend this with your real API contract when ready.
class ProfileModel {
  final bool? success;
  final String? message;
  final ProfileData? data;

  ProfileModel({this.success, this.message, this.data});

  factory ProfileModel.fromJson(dynamic json) {
    if (json is! Map) return ProfileModel();
    final map = json.cast<String, dynamic>();
    return ProfileModel(
      success: map['success'] as bool?,
      message: map['message'] as String?,
      data: map['data'] is Map ? ProfileData.fromJson(map['data']) : null,
    );
  }
}

class ProfileData {
  final String? name;
  final String? profile;

  ProfileData({this.name, this.profile});

  factory ProfileData.fromJson(dynamic json) {
    if (json is! Map) return ProfileData();
    final map = json.cast<String, dynamic>();
    return ProfileData(
      name: map['name'] as String?,
      profile: map['profile'] as String?,
    );
  }
}

