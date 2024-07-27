import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/common/values/shadows.dart';
import 'package:chatapp/common/widgets/button.dart';
import 'package:chatapp/pages/sign_in/controller.dart';
import 'package:chatapp/pages/sign_in/widget/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Widget buildLogo() {
    return Container(
      width: 120.w,
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 76.h,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 76.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      boxShadow: [Shadows.primaryShadow],
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    "assets/images/ic_launcher.png",
                    width: 80.w,
                    height: 76.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
            child: Text(
              "Chatty Chat",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.thirdElement,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SignInController());

    return Center(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h,),
                    buildLogo(),
                    Container(
                      width: 295.w,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(hintText: "Enter your name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 295.w,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: "Enter your email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 295.w,
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    btnFlatButtonWidget(
                      title: "Sign Up",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await Get.find<SignInController>().handleEmailSignUp(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          Get.back();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            fontFamily: 'Avenir',
                          ),
                        ),
                        SizedBox(width: 1.w),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Sign In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryElement,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              fontFamily: 'Avenir',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
