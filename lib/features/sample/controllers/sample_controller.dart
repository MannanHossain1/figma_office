 import '../../../core/exported_files/exported_file.dart';
import '../../../core/pagination/pagination_controller.dart';
import '../models/sample_model.dart';
import '../services/sample_paginated_service.dart';

class SampleController extends PaginationController<SampleData> {
  final SamplePaginatedService _service = Get.find<SamplePaginatedService>();
  final TextEditingController searchController = TextEditingController();

  SampleController() : super(pageSize: 4);

  @override
  Future<PaginatedResponse<SampleData>> fetchPage(
    int page,
    int pageSize,
  ) async {
    final term = searchController.text.trim();
    return _service.getItems(
      page: page,
      limit: pageSize,
      searchTerm: term.isEmpty ? null : term,
    );
  }

  void performSearch() => loadFirstPage();

  void clearSearch() {
    searchController.clear();
    loadFirstPage();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
