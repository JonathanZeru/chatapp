import 'package:chatapp/pages/sign_in/controller.dart';
import 'package:chatapp/pages/welcome/controller.dart';
import 'package:get/get.dart';
class SignInBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(()=> SignInController());
  }

}