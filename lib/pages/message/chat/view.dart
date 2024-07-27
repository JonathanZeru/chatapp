import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/pages/message/chat/controller.dart';
import 'package:chatapp/pages/message/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  AppBar buildAppBar(){
    return AppBar(
      backgroundColor: Color.fromARGB(255, 104, 132, 231),
      elevation: 0,
      title: Container(
        padding: EdgeInsets.only(
          top: 0.w,
          bottom: 0.w,
          right: 0.w
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 0.w,
                  bottom: 0.w,
                  right: 0.w
              ),
              child: InkWell(
                child: SizedBox(
                  width: 44.w,
                  height: 44.h,
                  child: controller.state.toAvatar.value == "" ?
                ClipOval(
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(
                      child: Text(controller.state.toName.value
                          != "" ?
                      controller.state.toName.value[0].toUpperCase() : "C",
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
                    errorWidget: (context, url, error)=>
                    Image.asset("assets/images/feature-1.png"),
                    imageUrl: controller.state.toAvatar.value,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 44.h,
                      width: 44.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                        fit: BoxFit.cover
                        )

                      ),
                    ),
                )
                ),
              ),
            ),
            Container(
              width: 110.w,
              padding: EdgeInsets.only(
                  top: 0.w,
                  bottom: 0.w,
                  right: 0.w
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 110.w,
                    height: 44.h,
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.state.toName.value,
                          overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBackground,
                              fontSize: 16.sp
                            )
                          ),

                        ]
                      )
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
  void showPicker(context){
    showModalBottomSheet(context: context,
        builder: (BuildContext context) {
          return SafeArea(child:
          Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Gallery"),
                onTap: (){
                  print("gallery");
                  controller.imageFromGallery();
                  Get.back();
                },
              )
            ],
          )
          );
        },);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: [
                ChatList(),
                Positioned(
                  bottom: 0.h,
                    height: 40.h,
                  child: Container(
                    width: 360.w,
                    height: 40.h,
                    color: AppColors.primaryBackground,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: 217.w,
                            height: 50.h,
                            child: Center(
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                maxLines: 2,
                                controller: controller.textController,
                                focusNode: controller.contentNode,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: "Send messages...",
                                  border: InputBorder.none, // Removes the border
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            child: IconButton(
                              icon: Icon(Icons.photo,
                                size: 25.w,
                                color: Colors.blue,),
                              onPressed: (){
                                showPicker(context);
                              }
                            )
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 35.h,
                            width: 80.w,
                            child: IconButton(
                              icon: Icon(Icons.send,
                                size: 25.w,
                                color: Colors.blue,),
                              onPressed: (){
                                if(controller.textController.text.isNotEmpty){
                                  controller.sendMessage();
                                }
                              },
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
