// sample of all common widgets how use that
import '../../../../core/exported_files/exported_file.dart';
import '../../../common/views/widgets/common_appbar.dart';
import '../widgets/sample_actions_showcase_widget.dart';
import '../widgets/sample_content_showcase_widget.dart';
import '../widgets/sample_form_showcase_widget.dart';
import '../widgets/sample_grid_carousel_showcase_widget.dart';
import '../widgets/sample_picker_empty_state_showcase_widget.dart';
import '../widgets/sample_profile_showcase_widget.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Hello"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SampleProfileShowcaseWidget(),
              ResponsiveSpace(18),
              SampleFormShowcaseWidget(),
              ResponsiveSpace(18),
              SampleActionsShowcaseWidget(),
              ResponsiveSpace(18),
              SampleContentShowcaseWidget(),
              ResponsiveSpace(18),
              SampleGridCarouselShowcaseWidget(),
              ResponsiveSpace(18),
              SamplePickerEmptyStateShowcaseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
