import 'package:b_potash/core/exported_files/exported_file.dart';
import 'package:b_potash/core/services/app_services/user_profile_models.dart';

class UserProfileService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  // Reactive profile data that can be observed across the app
  final Rxn<ProfileData> _profileData = Rxn<ProfileData>();
  Rx<ProfileData?> get profileData => _profileData;

  // Loading state
  final RxBool isLoading = false.obs;

  // Check if profile data is already cached
  bool get hasCachedProfile => _profileData.value != null;

  /// This method caches the data to avoid redundant API calls
  Future<ProfileData?> fetchProfile({bool forceRefresh = false}) async {
    // Return cached data if available and not forcing refresh
    if (!forceRefresh && hasCachedProfile) {
      return _profileData.value;
    }

    try {
      isLoading.value = true;
      final response = await _apiService.getData(url: ApiEndpoint.myProfile);

      if (response.isSuccess) {
        final profileModel = ProfileModel.fromJson(response.data);
        _profileData.value = profileModel.data;
        return profileModel.data;
      }

      return null;
    } catch (e) {
      DService().error("Error fetching profile: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }
  void updateCachedProfile(ProfileData? data) {
    _profileData.value = data;
  }

  void clearProfile() {
    _profileData.value = null;
  }

  String getProfileName() {
    return _profileData.value?.name ?? 'User';
  }

  /// Get profile image URL (with fallback)
  String? getProfileImageUrl() {
    return _profileData.value?.profile;
  }
}
