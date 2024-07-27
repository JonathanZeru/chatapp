import 'package:chatapp/common/entities/msg.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:chatapp/pages/message/state.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:location/location.dart';

class MessageController extends GetxController{
  MessageController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  final MessageState state = MessageState();
  var listener;
  final RefreshController refreshController = RefreshController(
      initialRefresh: true,
      );

  void onRefresh(){
    asyncLoadAllData().then((_){
      refreshController.refreshCompleted(
        resetFooterState: true
      );
    }).catchError((_){
      refreshController.refreshFailed();
    });
  }

  void onLoading(){
    asyncLoadAllData().then((_){
      refreshController.loadComplete();
    }).catchError((_){
      refreshController.loadFailed();
    });
  }
  asyncLoadAllData()async{
    var fromMessages = await db
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options)=>
        msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .get();
    var toMessages =await db
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options)=>
            msg.toFirestore())
        .where("to_uid", isEqualTo: token)
        .get();

    state.msgList.clear();
    if(fromMessages.docs.isNotEmpty){
      state.msgList.assignAll(fromMessages.docs);
    }
    if(toMessages.docs.isNotEmpty){
      state.msgList.assignAll(toMessages.docs);
    }

  }
}