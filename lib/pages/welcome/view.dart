import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/pages/welcome/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(()=>SizedBox(
            width: double.infinity,
            height: 780.h,
            child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    scrollDirection: Axis.horizontal,
                    reverse: false,
                    onPageChanged: (index){
                      controller.changePage(index);
                    },
                    controller: PageController(
                      initialPage: 0,
                      keepPage: false,
                      viewportFraction: 1,
                    ),
                    pageSnapping: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/ic_launcher.png",
                                width: 80.w,
                                height: 76.h,
                                fit: BoxFit.cover),
                            SizedBox(height: 30.h,),
                            Text( "Stay Connected with Ease",
                            style: TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                            fontSize: 18.sp
                            )),
                            SizedBox(height: 5.h,),
                            Text( "Seamlessly chat with friends and family, anytime, anywhere.",
                                style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText,
                                    fontSize: 14.sp,
                                ),
                            textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/ic_launcher.png",
                                width: 80.w,
                                height: 76.h,
                                fit: BoxFit.cover),
                            SizedBox(height: 30.h,),
                            Text( "Share Moments Instantly",
                                style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText,
                                    fontSize: 18.sp
                                )),
                            SizedBox(height: 5.h,),
                            Text( "Capture and share your favorite moments.",
                                style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText,
                                    fontSize: 14.sp
                                ),
                              textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(image:
                            AssetImage("assets/images/ic_launcher.png"))
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned(
                                bottom: 120,
                                child:
                                ElevatedButton(
                                  onPressed: (){
                                    controller.handleSignIn();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      foregroundColor: MaterialStateProperty.all(Colors.black),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          )
                                      ),
                                      side: MaterialStateProperty.all(
                                          BorderSide(color: Colors.white)
                                      )
                                  ),
                                  child: Text("Start chatting"),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 70,
                      child: DotsIndicator(
                        position: controller.state.index.value,
                        dotsCount: 3,
                        reversed: false,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                          size: Size.square(9),
                          activeSize: Size(18, 9),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                      ))
                ]
            )
        ))
      )
    );
  }
}
