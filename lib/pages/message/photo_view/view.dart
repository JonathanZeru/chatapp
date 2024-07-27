import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/common/widgets/app.dart';
import 'package:chatapp/pages/message/photo_view/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PhotoImgViewPage extends GetView<PhotoImageController> {
  const PhotoImgViewPage({super.key});
  AppBar buildAppBar(){
    return transparentAppBar(
        title: Text("Photo View",
          style: TextStyle(
              color: AppColors.primaryBackground,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: PhotoView(
          imageProvider: NetworkImage(
              controller.state.url.value
          )
      ),
    );
  }
}
