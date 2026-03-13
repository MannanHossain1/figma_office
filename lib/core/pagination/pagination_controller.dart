import '../exported_files/exported_file.dart';

class PaginatedResponse<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;

  const PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });

  bool get hasMore => currentPage < totalPages;
}

abstract class PaginationController<T> extends GetxController {
  PaginationController({
    this.pageSize = 20,
    this.useGlobalLoader = true,
    this.autoLoad = true,
  });

  final int pageSize;
  final bool useGlobalLoader;
  final bool autoLoad;

  // ── Observable state ──
  final RxList<T> items = <T>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreData = true.obs;

  final ScrollController scrollController = ScrollController();

  int _page = 1;
  static const double _scrollThreshold = 200;

  bool get isEmpty => items.isEmpty && !isLoading.value;

  // ── Abstract ──

  /// Fetch a single page of data from the backend.
  Future<PaginatedResponse<T>> fetchPage(int page, int pageSize);

  // ── Optional hooks ──

  /// Called after the first page loads successfully.
  void onFirstPageLoaded(List<T> data) {}

  /// Called after a subsequent page loads successfully.
  void onNextPageLoaded(List<T> data) {}

  // ── Lifecycle ──

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    if (autoLoad) loadFirstPage();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  // ── Public API ──

  Future<void> loadFirstPage() async {
    if (isLoading.value) return;

    isLoading.value = true;
    if (useGlobalLoader) CustomLoader.show();

    _page = 1;
    hasMoreData.value = true;

    try {
      final response = await fetchPage(_page, pageSize);
      items.assignAll(response.items);
      hasMoreData.value = response.hasMore;
      onFirstPageLoaded(response.items);
    } catch (_) {
      CustomLoader.showError("Failed to load data");
    } finally {
      isLoading.value = false;
      if (useGlobalLoader) CustomLoader.dismiss();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMoreData.value || isLoading.value) return;

    isLoadingMore.value = true;
    final nextPage = _page + 1;

    try {
      final response = await fetchPage(nextPage, pageSize);

      if (response.items.isNotEmpty) {
        items.addAll(response.items);
        onNextPageLoaded(response.items);
      }

      _page = nextPage;
      hasMoreData.value = response.hasMore;
    } catch (_) {
      CustomLoader.showError("Failed to load more");
    } finally {
      isLoadingMore.value = false;
    }
  }

  @override
  Future<void> refresh() async => loadFirstPage();

  // ── Private ──

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (isLoadingMore.value || !hasMoreData.value || isLoading.value) return;

    final max = scrollController.position.maxScrollExtent;
    final current = scrollController.position.pixels;
    if (max > 0 && current >= max - _scrollThreshold) {
      loadMore();
    }
  }
}
