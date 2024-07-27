import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/common/widgets/app.dart';
import 'package:chatapp/pages/contact/controller.dart';
import 'package:chatapp/pages/contact/widget/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {

    AppBar buildAppBar(){
      return transparentAppBar(
        title: Text("Contact",
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600
        ),
        )
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: ContactList()
      )
    );
  }
}
