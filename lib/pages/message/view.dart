import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/common/widgets/app.dart';
import 'package:chatapp/pages/message/controller.dart';
import 'package:chatapp/pages/message/widget/message_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar(){
      return transparentAppBar(
          title: Text("Recently",
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
          body: MessageList()
        )
    );
  }
}
