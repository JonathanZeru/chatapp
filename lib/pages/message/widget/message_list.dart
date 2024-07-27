import 'package:chatapp/common/entities/msg.dart';
import 'package:chatapp/common/utils/date.dart';
import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/pages/message/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({super.key});

  Widget messageListItem(QueryDocumentSnapshot<Msg> item){
    return Container(
      padding: EdgeInsets.only(
        top: 10.w,
        left: 15.w,
        right: 15.w
      ),
      child: InkWell(
        onTap: (){
          var to_uid = "";
          var to_name = "";
          var to_avatar = "";
          if(item.data().from_uid == controller.token){
            to_uid = item.data().to_uid ?? "";
            to_name = item.data().to_name ?? "";
            to_avatar = item.data().to_avatar ?? "";
          }else{
            to_uid = item.data().from_uid ?? "";
            to_name = item.data().from_name ?? "";
            to_avatar = item.data().from_avatar ?? "";
          }
          Get.toNamed("/chat", parameters: {
            "doc_id": item.id,
            "to_uid": to_uid,
            "to_name": to_name,
            "to_avatar": to_avatar
          });
        },
        child: ListTile(
          leading: Container(
            child: SizedBox(
                width: 54.w,
                height: 64.h,
                child: CachedNetworkImage(
                  imageUrl: item.data().from_uid == controller.token ?
                  item.data().to_avatar! : item.data().from_avatar!,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 54.w,
                      height: 54.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(54)),
                          image: DecorationImage(image: imageProvider,
                              fit: BoxFit.cover)
                      ),
                    );
                  },
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/feature-1.png"),
                )
            ),
          ),
          title: Text(item.data().from_uid == controller.token ?
              item.data().to_name!
              : item.data().from_name!,
            style: TextStyle(
                fontFamily: "Avenir",
                fontWeight: FontWeight.bold,
                color: AppColors.thirdElement,
                fontSize: 16.sp
            ),
          ),
          subtitle: Text(item.data().last_msg ?? "",
            style: TextStyle(
              fontFamily: "Avenir",
              fontWeight: FontWeight.w500,
              fontSize: 13.sp
            ),),
          trailing:  Text(duTimeLineFormat(
              (item.data().last_time as Timestamp).toDate()
          ),
            style: TextStyle(
                fontFamily: "Avenir",
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
              color: AppColors.thirdElementText
            ),)
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: controller.refreshController,
      onLoading: controller.onLoading,
      onRefresh: controller.onRefresh,
      header: WaterDropHeader(),
      child: controller.state.msgList.isEmpty ?
      Center(
        child: Text("No messages with any contact yet.",
          style: TextStyle(
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              fontSize: 16.sp
          ),),
      )
          : CustomScrollView(
          slivers: [
            SliverPadding(padding: EdgeInsets.symmetric(
                vertical: 0.w,horizontal: 0.w
            ),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          var item = controller.state.msgList[index];
                          return messageListItem(item);
                        },
                        childCount: controller.state.msgList.length
                    )
                )
            )
          ]
      )
    )
    );
  }
}
