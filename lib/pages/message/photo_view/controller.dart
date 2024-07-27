import 'package:chatapp/pages/message/photo_view/state.dart';
import 'package:get/get.dart';
class PhotoImageController extends GetxController{
  final PhotoImageViewState state = PhotoImageViewState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    if(data['url'] != null){
      state.url.value = data['url']!;
    }
  }

}