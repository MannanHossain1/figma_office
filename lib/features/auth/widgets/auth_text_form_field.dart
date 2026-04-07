import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_codebase/core/global_widgets/custom_textfield.dart';
class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String headerText;
  final bool isPassword;
  final RxBool? isPasswordHidden;
  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.headerText = '',
    this.isPassword = false,
    this.isPasswordHidden,
  });
  @override
  Widget build(BuildContext context) {
    if (isPassword && isPasswordHidden != null) {
      return Obx(() {
        return CustomTextfield(
          textController: controller,
          hintText: hintText,
          headertext: headerText,
          isObscure: isPasswordHidden!.value,
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
          suffixWidget: IconButton(
            icon: Icon(
              isPasswordHidden!.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey,
            ),
            onPressed: isPasswordHidden!.toggle,
          ),
        );
      });
    }
    return CustomTextfield(
      textController: controller,
      hintText: hintText,
      headertext: headerText,
      isObscure: false,
      prefixIcon: _getPrefixIcon(),
    );
  }
  Icon? _getPrefixIcon() {
    final text = hintText.toLowerCase();
    if (text.contains('email')) {
      return const Icon(Icons.email_outlined, color: Colors.grey);
    } else if (text.contains('phone') || text.contains('number')) {
      return const Icon(Icons.phone_outlined, color: Colors.grey);
    } else if (text.contains('name') || text.contains('full')) {
      return const Icon(Icons.person_outline, color: Colors.grey);
    }
    return null;
  }
}
