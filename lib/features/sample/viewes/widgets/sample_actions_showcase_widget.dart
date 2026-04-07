import '../../../../core/exported_files/exported_file.dart';
import 'sample_section_title.dart';
class SampleActionsShowcaseWidget extends StatefulWidget {
  const SampleActionsShowcaseWidget({super.key});
  @override
  State<SampleActionsShowcaseWidget> createState() =>
      _SampleActionsShowcaseWidgetState();
}
class _SampleActionsShowcaseWidgetState
    extends State<SampleActionsShowcaseWidget> {
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);
  final RxBool _isNotificationEnabled = false.obs;
  @override
  void dispose() {
    _isChecked.dispose();
    _isNotificationEnabled.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SampleSectionTitle(title: 'Buttons + Switch + Checkbox'),
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
                  onChanged: (value) => _isChecked.value = value ?? false,
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
                onChanged: (value) => _isNotificationEnabled.value = value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
