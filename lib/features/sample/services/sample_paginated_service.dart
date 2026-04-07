import '../../../core/exported_files/exported_file.dart';
import '../../../core/pagination/pagination_controller.dart';
import '../models/sample_model.dart';
class SamplePaginatedService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();
  Future<PaginatedResponse<SampleData>> getItems({
    required int page,
    required int limit,
    String? searchTerm,
  }) async {
    try {
      final query = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
        if (searchTerm != null && searchTerm.isNotEmpty)
          'searchTerm': searchTerm,
      };
      final response = await _apiService.getData(
        url: ApiEndpoint.sample,
        query: query,
      );
      if (response.isSuccess && response.data != null) {
        final model = SampleModel.fromJson(response.data);
        final count = model.data?.length ?? 0;
        final totalPage = model.meta?.totalPage ?? 0;
        DService().info('Items: $count items (page $page/$totalPage)');
        return PaginatedResponse(
          items: model.data ?? [],
          currentPage: model.meta?.page ?? 1,
          totalPages: model.meta?.totalPage ?? 1,
        );
      }
      DService().error('Items API failed: ${response.message ?? "unknown"}');
      return const PaginatedResponse(items: [], currentPage: 1, totalPages: 1);
    } catch (e) {
      DService().error('SamplePaginatedService: $e');
      return const PaginatedResponse(items: [], currentPage: 1, totalPages: 1);
    }
  }
}
