import '../../../core/exported_files/exported_file.dart';

class CommonSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String?)? onFieldSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onClear;
  final VoidCallback? onSearch;

  const CommonSearchField({
    super.key,
    this.controller,
    this.hintText,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.onFilterTap,
    this.onClear,
    this.onSearch,
  });

  @override
  State<CommonSearchField> createState() => _CommonSearchFieldState();
}

class _CommonSearchFieldState extends State<CommonSearchField> {
  late TextEditingController _controller;
  final showClearButton = false.obs;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    showClearButton.value = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onTextChanged);
    }
    super.dispose();
  }

  void _onTextChanged() {
    showClearButton.value = _controller.text.isNotEmpty;
    widget.onChanged?.call(_controller.text);
  }

  void _clearSearch() {
    _controller.clear();
    showClearButton.value = false;
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  void _handleFieldSubmitted(String? value) {
    widget.onFieldSubmitted?.call(value);
    widget.onSearch?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => ResponsiveInputField(
              controller: _controller,
              hintText: widget.hintText ?? "Search",
              onChanged: null, // Handled by _onTextChanged
              onFieldSubmitted: _handleFieldSubmitted,
              onTap: widget.onTap,
              borderRadius: 24,
              prefixIcon: Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 10,
                  top: 11,
                  bottom: 10,
                ),
                child: ResponsiveImage(
                  path: IconsAssetsPaths.search,
                  width: 5,
                  height: 5,
                ),
              ),
              suffixIcon: _buildSuffixIcon(),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (showClearButton.value) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _clearSearch,
            icon: Icon(
              Icons.close,
              color: AppColors.secondaryTxtColor,
              size: 20,
            ),
          ),
          if (widget.onFilterTap != null)
            IconButton(
              onPressed: widget.onFilterTap,
              icon: const Icon(Icons.filter_list),
            ),
          const SizedBox(width: 8),
        ],
      );
    }

    if (widget.onFilterTap != null) {
      return IconButton(
        onPressed: widget.onFilterTap,
        icon: const Icon(Icons.filter_list),
      );
    }

    return null;
  }
}
