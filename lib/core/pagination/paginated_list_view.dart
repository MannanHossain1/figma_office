import '../exported_files/exported_file.dart';
import 'pagination_controller.dart';

class PaginatedListView<T> extends StatelessWidget {
  const PaginatedListView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
    this.emptyWidget,
    this.padding,
    // this.noMoreDataText = 'No more data',
  });

  final PaginationController<T> controller;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget? emptyWidget;
  final EdgeInsetsGeometry? padding;
  // final String noMoreDataText;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.items.isEmpty) {
        return const SizedBox.shrink();
      }

      if (controller.isEmpty) {
        final empty =
            emptyWidget ??
            Center(
              child: ResponsiveText(
                text: 'No data found',
                fontSize: 14,
                color: AppColors.secondaryTxtColor,
              ),
            );

        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: ListView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: padding,
            children: [empty],
          ),
        );
      }

      final itemCount = controller.items.length;

      return RefreshIndicator(
        onRefresh: controller.refresh,
        child: ListView.separated(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: padding,
          itemCount: itemCount + 1,
          separatorBuilder:
              separatorBuilder ?? (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index < itemCount) {
              return itemBuilder(context, controller.items[index], index);
            }
            return _buildPaginationFooter();
          },
        ),
      );
    });
  }

  Widget _buildPaginationFooter() {
    return Obx(() {
      if (controller.isLoadingMore.value) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      }

      // if (!controller.hasMoreData.value && controller.items.isNotEmpty) {
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 24),
      //     child: Center(
      //       child: ResponsiveText(
      //         text: noMoreDataText,
      //         fontSize: 14,
      //         color: AppColors.secondaryTxtColor,
      //       ),
      //     ),
      //   );
      // }

      return const SizedBox.shrink();
    });
  }
}
