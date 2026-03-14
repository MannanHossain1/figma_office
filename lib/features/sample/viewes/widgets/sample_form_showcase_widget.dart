import '../../../../core/exported_files/exported_file.dart';
import 'sample_section_title.dart';

class SampleFormShowcaseWidget extends StatefulWidget {
  const SampleFormShowcaseWidget({super.key});

  @override
  State<SampleFormShowcaseWidget> createState() =>
      _SampleFormShowcaseWidgetState();
}

class _SampleFormShowcaseWidgetState extends State<SampleFormShowcaseWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final ValueNotifier<String?> _selectedRole = ValueNotifier<String?>(null);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SampleSectionTitle(title: 'Input + Dropdown + OTP'),
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
      ],
    );
  }
}
