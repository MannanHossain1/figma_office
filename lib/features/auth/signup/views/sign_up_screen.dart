import 'package:flutter_codebase/features/common/views/widgets/common_appbar.dart';

import '../../../core/exported_files/exported_file.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: CommonAppBar(
  isLeading: true,
    title: 'Choose Role'),

      body: ResponsiveContainer(
        child: ResponsiveText(text: 'Choose Your Role',fontSize: 25,),
      ),
    );
  }
}
