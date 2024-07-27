import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/routes/names.dart';
import 'package:chatapp/common/utils/date.dart';
import 'package:chatapp/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
Widget ChatLeftItem(Msgcontent item){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          padding: EdgeInsets.only(
              top: 5.w,
              left: 15.w,
              right: 15.w,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 200.w,
                        minHeight: 40.h
                    ),
                    child: Container(
                        margin: EdgeInsets.only(
                            right: 10.w, top: 0.w
                        ),
                        padding: EdgeInsets.only(
                            top: 10.w,
                            left: 10.w,
                            right: 10.w,
                            bottom: 10.w
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 176, 106, 231),
                              Color.fromARGB(255, 166, 112, 232),
                              Color.fromARGB(255, 131, 123, 232),
                              Color.fromARGB(255, 104, 132, 231),
                            ],transform: GradientRotation(90),),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.w)
                            )
                        ),
                        child: item.type == 'text' ?
                        Text("${item.content}",
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBackground,
                                fontSize: 13.sp
                            )) :
                        ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: 90.w
                            ),
                            child: GestureDetector(
                                onTap: (){
                                  Get.toNamed(
                                    AppRoutes.Photoimgview,
                                    parameters: {
                                      "url": item.content ?? ""
                                    }
                                  );
                                },
                                child: CachedNetworkImage(
                                    imageUrl: "${item.content!}"
                                )
                            )
                        )
                    )
                )
              ]
          )
      ),
      Container(
        padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            bottom: 5.w
        ),
        child: Text(duTimeLineFormat(
            (item.addtime as Timestamp).toDate()
        ),
            style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
                fontSize: 8.sp
            )),
      )
    ],
  );
}