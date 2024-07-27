import 'dart:convert';

import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/routes/names.dart';
import 'package:chatapp/common/store/user.dart';
import 'package:chatapp/pages/profile/state.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController{
  final ProfileState state = ProfileState();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]
  );

  asyncLoadAllData()async{
    state.isLoading.value = true;
    String profile = await UserStore.to.getProfile();
    if(profile.isNotEmpty){
      UserLoginResponseEntity userData =
      UserLoginResponseEntity.fromJson(jsonDecode(profile));
      state.headDetail.value = userData;
    }
    state.isLoading.value = false;
  }
  Future<void> onLogOut()async{
    UserStore.to.onLogout();
    await googleSignIn.signOut();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    asyncLoadAllData();
    List MyList = [
      {"name": "Logout", "icon": "assets/icons/7.png", "route":"/logout"}
    ];
    for(int i=0; i < MyList.length; i++){
      MeListItem result = MeListItem();
      result.icon = MyList[i]["icon"];
      result.name = MyList[i]["name"];
      result.route = MyList[i]["route"];
      state.meListItem.add(result);
    }
  }
}