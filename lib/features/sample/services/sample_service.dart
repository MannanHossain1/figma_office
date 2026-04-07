import '../../../core/exported_files/exported_file.dart';
import '../models/sample_model.dart';

class SampleService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Fetch all items (no pagination)

  /// GET /sample-endpoint
  Future<List<SampleData>> getItems({String? filter1, String? filter2}) async {
    final query = <String, dynamic>{
      if (filter1 != null && filter1.isNotEmpty) 'filter1': filter1,
      if (filter2 != null && filter2.isNotEmpty) 'filter2': filter2,
    };

    final response = await _apiService.getData(
      url: ApiEndpoint.sample,
      query: query.isNotEmpty ? query : null,
    );

    if (response.isSuccess && response.data != null) {
      try {
        final model = SampleModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        DService().info("Items fetched: ${model.data?.length ?? 0}");
        return model.data ?? [];
      } catch (e) {
        DService().error("Error parsing items: $e");
        return [];
      }
    }
    return [];
  }

  /// Fetch item by ID
  /// GET /sample-endpoint/{id}
  Future<SampleData?> getById({required String id}) async {
    final response = await _apiService.getData(url: ApiEndpoint.sampleById(id));

    if (response.isSuccess && response.data != null) {
      try {
        final model = SampleData.fromJson(response.data);
        DService().info("Item fetched: ${model.name}");
        return model;
      } catch (e) {
        DService().error("Error parsing item: $e");
        return null;
      }
    }
    return null;
  }

  /// Create item
  /// POST /sample-endpoint
  Future<SampleData?> create({required Map<String, dynamic> body}) async {
    final response = await _apiService.postData(
      url: ApiEndpoint.sample,
      body: body, // body will pass on controller
    );

    if (response.isSuccess && response.data != null) {
      try {
        final model = SampleData.fromJson(response.data);
        DService().info("Created: ${model.id}");
        return model;
      } catch (e) {
        DService().error("Error parsing created item: $e");
        return null;
      }
    }
    return null;
  }

  /// Update item
  /// PATCH /sample-endpoint/{id}
  Future<bool> update({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    final response = await _apiService.patchData(
      url: ApiEndpoint.sampleById(id),
      body: body,
    );

    if (response.isSuccess) {
      DService().info("Updated successfully");
      return true;
    }
    DService().error("Update failed: ${response.message}");
    return false;
  }
  /// Delete item
  /// DELETE /sample-endpoint/{id}
  Future<bool> delete(String id) async {
    final response = await _apiService.deleteData(
      url: ApiEndpoint.sampleById(id),
    );
    if (response.isSuccess) {
      DService().info("Deleted successfully");
      return true;
    }
    DService().error("Delete failed: ${response.message}");
    return false;
  }
}
