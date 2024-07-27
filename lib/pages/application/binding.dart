import 'package:chatapp/pages/application/controller.dart';
import 'package:chatapp/pages/contact/controller.dart';
import 'package:chatapp/pages/message/controller.dart';
import 'package:chatapp/pages/profile/controller.dart';
import 'package:chatapp/pages/sign_in/controller.dart';
import 'package:chatapp/pages/welcome/controller.dart';
import 'package:get/get.dart';
class ApplicationBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(()=> ApplicationController());
    Get.lazyPut<ContactController>(()=> ContactController());
    Get.lazyPut<MessageController>(()=> MessageController());
    Get.lazyPut<ProfileController>(()=> ProfileController());
  }

}