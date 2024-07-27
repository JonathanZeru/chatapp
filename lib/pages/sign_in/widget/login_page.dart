import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/common/widgets/button.dart';
import 'package:chatapp/common/widgets/input.dart';
import 'package:chatapp/pages/sign_in/controller.dart';
import 'package:chatapp/pages/sign_in/widget/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends GetView<SignInController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Spacer(),
              inputTextEdit(
                controller: emailController,
                hintText: "Enter your email",
              ),
              inputTextEdit(
                controller: passwordController,
                hintText: "Enter your password",
                isPassword: true,
              ),
              btnFlatButtonWidget(
                title: "Sign In",
                onPressed: () {
                  controller.handleEmailSignIn(
                    emailController.text,
                    passwordController.text,
                  );
                },
              ),
              btnFlatButtonWidget(
                title: "Don't have an account? Sign Up",
                onPressed: () {
                  Get.to(()=>RegistrationPage());
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
