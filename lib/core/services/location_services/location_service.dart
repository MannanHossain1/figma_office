import 'package:flutter_codebase/core/exported_files/exported_file.dart';

class LocationService extends GetxService {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxBool isLocationEnabled = false.obs;

  /// Check and fetch current location
  Future<void> checkAndFetchLocation() async {
    DService().info("=== Starting Location Permission Request ===");
    
    // Check if location service is enabled
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      DService().warning("Location services are disabled on device.");
      return;
    }
    DService().info("Location services are enabled.");

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    DService().info("Current permission status: $permission");
    
    if (permission == LocationPermission.denied) {
      DService().info("Requesting location permission...");
      permission = await Geolocator.requestPermission();
      DService().info("Permission after request: $permission");
    }

    if (permission == LocationPermission.deniedForever) {
      DService().warning("Location permission permanently denied.");
      return;
    }

    // Permission granted - fetch location
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      DService().info("Permission granted. Fetching current position...");
      try {
        final Position pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 0,
          ),
        );
        currentPosition.value = pos;
        isLocationEnabled.value = true;
        DService().info("=== Location Fetched Successfully ===");
        DService().info("Latitude: ${pos.latitude}");
        DService().info("Longitude: ${pos.longitude}");
      } catch (e) {
        DService().error("Failed to get location: $e");
      }
    } else {
      DService().warning("Location permission not granted: $permission");
    }
  }

  /// Get current latitude
  double? get latitude => currentPosition.value?.latitude;

  /// Get current longitude
  double? get longitude => currentPosition.value?.longitude;

  /// Check if location is available
  bool get hasLocation => currentPosition.value != null;
}
