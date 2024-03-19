import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../controllers/auth_controller.dart';
import '../models/call_model.dart';
import 'call_repo.dart';

class CallController extends GetxController {
  CallRepository callRepository = CallRepository();
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthController authController = Get.put(AuthController());
  Stream<DocumentSnapshot> get callStream => callRepository.callStream;
 

  void makeCall(
    BuildContext context,
    String receiverName,
    String receiverUid,
    String receiverProfilePic,
  )async {
    DocumentSnapshot<Map<String, dynamic>> document=await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
    final data = document.data()!;
      String userName = data['username'] ;
      String userImage = data['image'] ;
  
    String callId = const Uuid().v1();
    Call senderCallData = Call(
      callerId: auth.currentUser!.uid,
      callerName: userName,
      callerPic: userImage,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: true,
    );

    Call recieverCallData = Call(
      callerId: auth.currentUser!.uid,
      callerName: userName,
      callerPic: userImage,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: false,
    );

    callRepository.makeCall(senderCallData, context, recieverCallData);
  }

  void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) {
    callRepository.endCall(callerId, receiverId, context);
  }
}
//