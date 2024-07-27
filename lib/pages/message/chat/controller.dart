import 'dart:io';
import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:chatapp/common/utils/security.dart';
import 'package:chatapp/pages/message/chat/state.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();
  var docId = null;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final userId = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;
  File? photo;
  final ImagePicker picker = ImagePicker();

  Future<void> sendImageMessage(String url) async {
    print("url = $url");
    var content = Msgcontent(
      uid: userId,
      content: url,
      type: "image",
      addtime: Timestamp.now(),
    );
    await db
        .collection('message')
        .doc(docId)
        .collection("msgList")
        .withConverter(
      fromFirestore: Msgcontent.fromFirestore,
      toFirestore: (Msgcontent msgContent, options) =>
          msgContent.toFirestore(),
    )
        .add(content)
        .then((DocumentReference doc) {
      print("Document added with id ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection('message').doc(docId).update({
      "last_msg": " [image] ",
      "last_time": Timestamp.now(),
    });
  }

  Future<void> imageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    print("pickedFile = $pickedFile");

    if (pickedFile != null) {
      photo = File(pickedFile.path);
      print("photo = ${pickedFile.path}");
      uploadFile();
    } else {
      print("No image selected");
    }
  }

  Future<String> getImageUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str;
  }

  Future<void> uploadFile() async {
    if (photo == null) return;
    final fileName = getRandomString(15) + path.extension(photo!.path);
    try {
      print("fileName = $fileName");

      final ref = FirebaseStorage.instance.ref("chat").child(fileName);
      print("ref = $ref");
      print("photo = $photo");
      print("photo path = ${photo!.path}");

      await ref.putFile(photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imageUrl = await getImageUrl(fileName);
            print("imageUrl = $imageUrl");
            sendImageMessage(imageUrl);
            break;
          case TaskState.canceled:
            print("Upload canceled");
            break;
          case TaskState.error:
            print("Upload error");
            break;
        }
      });
    } catch (e) {
      print("There is an error: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    docId = data['doc_id'] ?? '';
    state.toUid.value = data['to_uid'] ?? "";
    state.toName.value = data['to_name'] ?? "";
    state.toAvatar.value = data['to_avatar'] ?? "";
  }

  Future<void> sendMessage() async {
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: userId,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
    );
    await db
        .collection('message')
        .doc(docId)
        .collection("msgList")
        .withConverter(
      fromFirestore: Msgcontent.fromFirestore,
      toFirestore: (Msgcontent msgContent, options) =>
          msgContent.toFirestore(),
    )
        .add(content)
        .then((DocumentReference doc) {
      print("Document added with id ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection('message').doc(docId).update({
      "last_msg": sendContent,
      "last_time": Timestamp.now(),
    });
  }

  Future<void> asyncLoadAllData() async {
    var fromMessages = await db
        .collection("message")
        .doc(docId)
        .collection("msgList")
        .orderBy('addtime', descending: true)
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .get();

    state.msgContentList.clear();
    if (fromMessages.docs.isNotEmpty) {
      state.msgContentList.assignAll(fromMessages.docs.map((doc) => doc.data()));
    }
  }

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();

    var messages = db
        .collection('message')
        .doc(docId)
        .collection('msgList')
        .withConverter(
      fromFirestore: Msgcontent.fromFirestore,
      toFirestore: (Msgcontent msg, options) => msg.toFirestore(),
    ).orderBy("addtime", descending: false);
    state.msgContentList.clear();
    listener = messages.snapshots().listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            if (change.doc.data() != null) {
              state.msgContentList.insert(0, change.doc.data()!);
            }
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    }, onError: (error) => print("Listen failed $error"));
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
