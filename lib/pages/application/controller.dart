import 'package:chatapp/common/style/color.dart';
import 'package:chatapp/common/values/colors.dart';
import 'package:chatapp/pages/application/state.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ApplicationController extends GetxController{
  final state = ApplicationState();
  ApplicationController();
  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;
  void handlePageChange(int index){
    state.page = index;
  }
  void handleNavBarTap(int index){
    pageController.jumpToPage(index);
  }
  @override
  void onInit(){
    tabTitles = [
      'Recently',
      'Contact',
      'Profile'
    ];
    bottomTabs = [
      BottomNavigationBarItem(icon:
      Icon(Icons.message_outlined,
      color: AppColors.thirdElementText
      ),
      activeIcon: Icon(
        Icons.message_outlined,
        color: AppColors.primaryElement
      ),
        label: 'Recently',
        backgroundColor: AppColors.primaryBackground
      ),

      BottomNavigationBarItem(icon:
      Icon(Icons.contact_page_outlined,
          color: AppColors.thirdElementText
      ),
          activeIcon: Icon(
              Icons.contact_page_outlined,
              color: AppColors.primaryElement
          ),
          label: 'Contact',
          backgroundColor: AppColors.primaryBackground
      ),
      BottomNavigationBarItem(icon:
      Icon(Icons.person,
          color: AppColors.thirdElementText
      ),
          activeIcon: Icon(
              Icons.person,
              color: AppColors.primaryElement
          ),
          label: 'Profile',
          backgroundColor: AppColors.primaryBackground
      ),
    ];
    pageController = PageController(
      initialPage: state.page
    );
  }
  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }
}