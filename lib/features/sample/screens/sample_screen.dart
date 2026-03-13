import '../../../core/exported_files/exported_file.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final ValueNotifier<String?> _selectedRole = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);

  final RxBool _isNotificationEnabled = false.obs;
  final RxInt _selectedRating = 3.obs;

  final List<String> _roleOptions = const <String>[
    'Admin',
    'Manager',
    'Operator',
    'Viewer',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _otpController.dispose();
    _selectedRole.dispose();
    _isChecked.dispose();
    _isNotificationEnabled.close();
    _selectedRating.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenSize.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const ResponsiveText(
          text: 'Custom Wrapper Showcase',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryTxtColor,
        ),
        backgroundColor: AppColors.appBarBackgroundColor,
        elevation: 0,
        actions: [
          ResponsiveIcon(
            icon: Icons.info_outline,
            color: AppColors.primaryColor,
            margin: const EdgeInsets.only(right: 12),
            onTap: () {
              CustomLoader.showInfo(
                'This screen demonstrates your custom widgets',
              );
            },
          ),
        ],
      ),
      backgroundColor: AppColors.primarySCBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Text + Container + Image'),
              ResponsiveContainer(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ResponsiveImage(
                      path: ImageAssetsPaths.userProfile,
                      width: 64,
                      height: 64,
                      shape: BoxShape.circle,
                    ),
                    const ResponsiveSpace(12),
                    const Expanded(
                      child: ResponsiveText(
                        text:
                            'Reusable profile tile built with ResponsiveContainer, ResponsiveImage, and ResponsiveText.',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryTxtColor,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),

              const ResponsiveSpace(18),
              _sectionTitle('Input + Dropdown + OTP'),
              ResponsiveInputField(
                controller: _nameController,
                hintText: 'Enter your name',
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const ResponsiveSpace(10),
              AppDropdownField(
                headerTitle: 'Role',
                hintText: 'Select role',
                controller: _roleController,
                isDropdown: true,
                dropdownItems: _roleOptions,
                selectedValueNotifier: _selectedRole,
              ),
              OtpField(
                otpController: _otpController,
                length: 4,
                onCompleted: (value) {
                  CustomLoader.showSuccess('OTP completed: $value');
                },
              ),

              const ResponsiveSpace(18),
              _sectionTitle('Buttons + Switch + Checkbox'),
              ResponsiveButton(
                title: 'Primary Action',
                onTap: () {
                  CustomLoader.showToast('Primary button tapped');
                },
              ),
              const ResponsiveSpace(10),
              GhostButton(
                title: 'Ghost Action',
                onTap: () {
                  CustomLoader.showWarning('Ghost button tapped');
                },
              ),
              const ResponsiveSpace(12),
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _isChecked,
                    builder: (context, checked, _) {
                      return ResponsiveCheckbox(
                        value: checked,
                        onChanged: (v) => _isChecked.value = v ?? false,
                        size: 20,
                      );
                    },
                  ),
                  const ResponsiveSpace(8),
                  const ResponsiveText(
                    text: 'Accept terms',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  Obx(
                    () => ResponsiveSwitch(
                      value: _isNotificationEnabled.value,
                      onChanged: (v) => _isNotificationEnabled.value = v,
                    ),
                  ),
                ],
              ),

              const ResponsiveSpace(18),
              _sectionTitle('Expandable + Dotted Divider + Rating'),
              const ExpandableText(
                text:
                    'This wrapper helps you keep long content compact. Tap See More to expand and See Less to collapse while preserving your custom text style.',
                maxLines: 2,
                fontSize: 14,
              ),
              const ResponsiveSpace(12),
              const DottedLine(),
              const ResponsiveSpace(12),
              InteractiveRatingWidget(
                initialRating: 3,
                selectedRating: _selectedRating,
                updateButtonLabel: 'Update Rating',
                onRatingChanged: (rating) {
                  _selectedRating.value = rating;
                },
                onUpdatePressed: () {
                  CustomLoader.showInfo(
                    'Rating updated to ${_selectedRating.value}',
                  );
                },
              ),

              const ResponsiveSpace(18),
              _sectionTitle('Grid + Carousel'),
              ResponsiveSizedBox(
                height: 180,
                child: ResponsiveGridView(
                  itemCount: 4,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ResponsiveContainer(
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? AppColors.primaryColor.withValues(alpha: 0.12)
                            : AppColors.secondaryColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: ResponsiveText(
                        text: 'Item ${index + 1}',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
              const ResponsiveSpace(12),
              const AppCarouselSlider(
                imageUrls: [
                  'https://picsum.photos/900/400?1',
                  'https://picsum.photos/900/400?2',
                  'https://picsum.photos/900/400?3',
                ],
                height: 170,
              ),

              const ResponsiveSpace(18),
              _sectionTitle('Image Picker + Empty State'),
              RImagePicker(
                width: double.infinity,
                height: 50,

                // fallbackImagePath: ImageAssetsPaths.userProfile,
                // fallbackImageHeight: 70,
                // fallbackImageWidth: 70,
                // allowMultiple: true,
              ),
              const ResponsiveSpace(14),
              const ResponsiveSizedBox(
                height: 220,
                child: EmptyState(
                  title: 'DEMO',
                  subtitle: 'All custom wrappers are ready to reuse',
                  buttonText: 'Refresh',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ResponsiveText(
        text: title,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
      ),
    );
  }
}
