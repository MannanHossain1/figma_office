import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_codebase/features/common/views/widgets/common_appbar.dart';
import '../../../core/exported_files/exported_file.dart';
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: CommonAppBar(title: 'Verification Code', isLeading: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveText(text: 'Verifiaction Code', fontSize: 28, fontWeight: FontWeight.w400,),
            ResponsiveText(text: 'Enter The verification Code that we have sent to your email', fontSize: 14, fontWeight: FontWeight.w400,),
            ResponsiveSizedBox(height: 32),
            OtpField(otpController: TextEditingController(),),
            ResponsiveSizedBox(height: 100),
            ResponsiveButton(
              title: 'Continue',backgroundColor: AppColors.primaryColor,
              onTap: (){
                showFlexibleBottomSheet(
                  context: context,
                  minHeight: 0.0,
                  initHeight: 0.8,
                  maxHeight: 0.8,
                  isExpand: false,
                  builder: (context, scrollController, bottomSheetOffset) {
                    return Material(
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        children: [
                          Image.asset(ImageAssetsPaths.success)
                        ],
                      ),
                    );
                  },
                );
              },
            )
          ]
        ),
      ),
    );
  }
}
