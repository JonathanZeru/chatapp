import 'package:chatapp/pages/application/controller.dart';
import 'package:chatapp/pages/contact/controller.dart';
import 'package:chatapp/pages/sign_in/controller.dart';
import 'package:chatapp/pages/welcome/controller.dart';
import 'package:get/get.dart';
class ContactBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(()=> ContactController());
  }

}