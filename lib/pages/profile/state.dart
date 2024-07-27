import 'package:chatapp/common/entities/entities.dart';
import 'package:get/get.dart';
class ProfileState{
  var headDetail = Rx<UserLoginResponseEntity?>(null);
  RxList<MeListItem> meListItem = <MeListItem>[].obs;
  RxBool isLoading = false.obs;
  bool get getIsLoading => isLoading.value;
  set setIsLoading(value) => isLoading.value = value;
}