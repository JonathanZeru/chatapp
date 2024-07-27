import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/common/values/shadows.dart';
import 'package:chatapp/common/widgets/button.dart';
import 'package:chatapp/pages/application/controller.dart';
import 'package:chatapp/pages/contact/index.dart';
import 'package:chatapp/pages/message/view.dart';
import 'package:chatapp/pages/profile/view.dart';
import 'package:chatapp/pages/sign_in/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildPageView(){
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChange,
        children: [
          MessagePage(),
          ContactPage(),
          ProfilePage()
        ],
      );
    }
    Widget buildBottomNavigationBar(){
      return Obx(
              ()=> BottomNavigationBar(items:
      controller.bottomTabs,
                currentIndex: controller.state.page,
                type: BottomNavigationBarType.fixed,
                onTap: controller.handleNavBarTap,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                unselectedItemColor: AppColors.tabBarElement,
                selectedItemColor: AppColors.primaryElement,
      )
      );
    }
    return SafeArea(
      child: Scaffold(
        body: buildPageView(),
        bottomNavigationBar: buildBottomNavigationBar(),
      )
    );
  }
}
