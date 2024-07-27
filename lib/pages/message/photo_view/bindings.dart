import 'package:chatapp/pages/message/photo_view/controller.dart';
import 'package:get/get.dart';

class PhotoImgViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PhotoImageController>(()=> PhotoImageController());
  }

}