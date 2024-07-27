import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/routes/routes.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:chatapp/common/widgets/toast.dart';
import 'package:chatapp/pages/sign_in/state.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'openid',
    'email',
    'profile',
  ],
);

class SignInController extends GetxController {
  final state = SignInState();
  final db = FirebaseFirestore.instance;

  Future<void> handleSignIn() async {
    try {
      var user = await googleSignIn.signIn();
      print("user = $user");
      if (user != null) {
        final gAuthentication = await user.authentication;
        print("gAuthentication = $gAuthentication");
        final credential = GoogleAuthProvider.credential(
          idToken: gAuthentication.idToken,
          accessToken: gAuthentication.accessToken,
        );
        print("credential = $credential");

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";
        print("displayName = $displayName");
        print("email = $email");

        await FirebaseAuth.instance.signInWithCredential(credential);


        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);

        var userBase = await db.collection('users')
            .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore()
        ).where("id", isEqualTo: id).get();

        if(userBase.docs.isEmpty){
          final data= UserData(
              id: id,
              name: displayName,
              email: email,
              photourl: photoUrl,
              fcmtoken: "",
              location: "",
              addtime: Timestamp.now()
          );
          var userBase =
          await db.collection('users')
              .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options)=>
                userData.toFirestore(),
          ).add(data);
        }

        toastInfo(msg: "Login successful");
        Get.offAndToNamed(AppRoutes.Application);
      } else {
        print("User may be logged in");
      }
    } catch (e) {
      toastInfo(msg: "Login Error");
      print("Error = $e");
    }
  }

  Future<void> handleEmailSignIn(String email, String password) async {
    print(email);
    print(password);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("userCredential = $userCredential");

      String id = userCredential.user!.uid;
      print("id = $id");

      var userDoc = await db.collection('users')
          .where("id", isEqualTo: id).get();
      print("userDoc = ${userDoc.docs[0].data()}");
      if (userDoc.docs[0].exists) {
        var userData = userDoc.docs[0].data()!;
        print("userData = $userData");

        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = userData['email'];
        userProfile.accessToken = id;
        userProfile.displayName = userData['name'];
        userProfile.photoUrl = userData['photourl'] ?? "";

        UserStore.to.saveProfile(userProfile);

        toastInfo(msg: "Login successful");
        Get.offAndToNamed(AppRoutes.Application);
      } else {
        toastInfo(msg: "User not found in Firestore");
      }
    } catch (e) {
      toastInfo(msg: "Login Error");
      print("Error = $e");
    }
  }

  Future<void> handleEmailSignUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String id = userCredential.user!.uid;

      UserLoginResponseEntity userProfile = UserLoginResponseEntity();
      userProfile.email = email;
      userProfile.accessToken = id;
      userProfile.displayName = name;
      userProfile.photoUrl = "";

      // Saving password (not recommended)
      userProfile.password = password;

      UserStore.to.saveProfile(userProfile);

      final data = UserData(
        id: id,
        name: name,
        email: email,
        photourl: "",
        fcmtoken: "",
        location: "",
        addtime: Timestamp.now(),
        password: password, // Storing password (not recommended)
      );
      await db.collection('users').withConverter(
        fromFirestore: UserData.fromFirestore,
        toFirestore: (UserData userData, options) => userData.toFirestore(),
      ).add(data);

      toastInfo(msg: "Registration successful");
      Get.offAndToNamed(AppRoutes.Application);
    } catch (e) {
      toastInfo(msg: e.toString());
      print("Error = $e");
    }
  }

  @override
  void onReady() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is currently logged out");
      } else {
        print("User is logged in");
      }
    });
  }
}
