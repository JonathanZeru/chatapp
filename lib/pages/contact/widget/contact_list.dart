import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/pages/contact/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {

    Widget buildListItem(UserData item){
      return Container(
        child: InkWell(
          onTap: (){
            if(item.id != null){
              controller.goChat(item);
            }
          },
          child: ListTile(
            leading:  Container(
              child: SizedBox(
                  width: 54.w,
                  height: 64.h,
                  child: item.photourl == null || item.photourl == "" ?
                      ClipOval(
                        child: Container(
                            width: 24.w,
                            height: 24.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryElement,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: Text(item.name!=null || item.name != "" ?
                            item.name![0].toUpperCase() : "C",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18.sp,
                              ),
                            textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                      : CachedNetworkImage(
                      imageUrl: "${item.photourl!}"
                  )
              ),
            ),
            title: Text(item.name ?? "",
            style: TextStyle(
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              color: AppColors.thirdElement,
              fontSize: 16.sp
            ),
            ),
            subtitle: Text(item.email ?? "",
              style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w500,
              ),),
          )
        ),
      );
    }

    return Obx(()=>CustomScrollView(
      slivers: [
        SliverPadding(padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index){
                    var item = controller.state.contactList[index];
                    return buildListItem(item);
                  },
                  childCount: controller.state.contactList.length
              )
          ),
        )
      ],
    ));
  }
}
