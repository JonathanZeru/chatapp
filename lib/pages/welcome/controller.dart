import 'package:chatapp/common/routes/names.dart';
import 'package:chatapp/common/store/config.dart';
import 'package:chatapp/pages/welcome/state.dart';
import 'package:get/get.dart';
class WelcomeController extends GetxController{
  final state = WelcomeState();
  WelcomeController();
  changePage(int index){
    state.index.value = index;
  }
  handleSignIn() async{
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}