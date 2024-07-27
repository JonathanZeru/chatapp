import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/common/widgets/app.dart';
import 'package:chatapp/common/widgets/button.dart';
import 'package:chatapp/pages/profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar(){
      return transparentAppBar(
          title: Text("Profile",
            style: TextStyle(
                color: AppColors.primaryBackground,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600
            ),
          )
      );
    }
    // Widget MeItem(MeListItem item){
    //   return  InkWell(
    //       onTap: (){
    //
    //       },
    //       child: ListTile(
    //         leading:  Container(
    //           child: SizedBox(
    //               width: 54.w,
    //               height: 64.h,
    //               child: item. == null || item.photourl == "" ?
    //               ClipOval(
    //                 child: Container(
    //                   width: 24.w,
    //                   height: 24.h,
    //                   decoration: BoxDecoration(
    //                       color: AppColors.primaryElement,
    //                       borderRadius: BorderRadius.circular(100)
    //                   ),
    //                   child: Center(
    //                     child: Text(item.name!=null || item.name != "" ?
    //                     item.name![0].toUpperCase() : "C",
    //                       style: TextStyle(
    //                         fontFamily: "Avenir",
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white,
    //                         fontSize: 18.sp,
    //                       ),
    //                       textAlign: TextAlign.center,
    //                     ),
    //                   ),
    //                 ),
    //               )
    //                   : CachedNetworkImage(
    //                   imageUrl: "${item.photourl!}"
    //               )
    //           ),
    //         ),
    //         title: Text(item.name ?? "",
    //           style: TextStyle(
    //               fontFamily: "Avenir",
    //               fontWeight: FontWeight.bold,
    //               color: AppColors.thirdElement,
    //               fontSize: 16.sp
    //           ),
    //         ),
    //         subtitle: Text(item.email ?? "",
    //           style: TextStyle(
    //             fontFamily: "Avenir",
    //             fontWeight: FontWeight.w500,
    //           ),),
    //       )
    //   );
    // }
    return SafeArea(
        child: Scaffold(
            appBar: buildAppBar(),
            body: Stack(
              children: [
                Positioned(
                  top: 10.w,
                  right: 10.w,
                  left: 10.w,
                  child: InkWell(
                      onTap: (){

                      },
                      child: Obx(()=>controller.state.isLoading.value == true ?
                      CircularProgressIndicator()
                          :ListTile(
                        leading:  Container(
                          child: SizedBox(
                              width: 54.w,
                              height: 64.h,
                              child: controller.state.headDetail.value?.photoUrl == null || controller.state.headDetail.value?.photoUrl == "" ?
                              ClipOval(
                                child: Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryElement,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller.state.headDetail.value!.displayName != null ||
                                          controller.state.headDetail.value!.displayName != "" ?
                                      controller.state.headDetail.value!.displayName![0].toUpperCase() : "C",
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
                                  imageUrl: "${controller.state.headDetail.value!.photoUrl!}"
                              )
                          ),
                        ),
                        title: Text(controller.state.headDetail.value!.displayName ?? "",
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdElement,
                              fontSize: 16.sp
                          ),
                        ),
                        subtitle: Text(controller.state.headDetail.value!.email ?? "",
                          style: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w500,
                          ),),
                      ))
                  ),
                ),
                Positioned(
                  bottom: 10.w,
                  left: 10.w,
                  right: 10.w,
                  child: Padding(padding: EdgeInsets.only(
                      top: 30.h, left: 50.w, right: 50.w
                  ),
                    child: btnFlatButtonWidget(
                        title: "Log out",
                        height: 55.h,
                        width: 200.w,
                        onPressed: ()=>controller.onLogOut()),
                  )
                )

              ],
            )
        )
    );
}
}