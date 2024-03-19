import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/call_model.dart';
import '../utils/config.dart';
import 'call_controller.dart';

class CallScreen extends StatefulWidget {
  final String channelId;
  final Call call;
  final bool isGroupChat;
  const CallScreen(
      {super.key,
      required this.channelId,
      required this.call,
      required this.isGroupChat});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
 

  CallController callController = Get.put(CallController());

  AgoraClient? client;
  String baseUrls =
      '007eJxTYFjIumbuOqnUWUVnQj7Y75A8/eVuiFPXpg+s+W+WuHW6FdgoMKQZGCcmJxuZmySnGZgkJSVZWppZGJtaJBsZJRonGVukPVn3KrUhkJGh36GDiZEBAkF8TobsxLz8/LzEggIGBgBoIyNM';
  String baseUrl = 'https://whatsapp-clone-rrr.herokuapp.com';

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: baseUrl,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

// Disp
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const CircularProgressIndicator()
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: client!),
                  AgoraVideoButtons(
                    client: client!,
                    disconnectButtonChild: IconButton(
                      onPressed: () async {
                        await client!.engine.leaveChannel();
                        callController.endCall(
                          widget.call.callerId,
                          widget.call.receiverId,
                          context,
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.call_end,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:math' as math;


// class VideoCallScreen extends StatefulWidget {
// const VideoCallScreen(
// {super.key,
// this.agoraToken='007eJxTYFjIumbuOqnUWUVnQj7Y75A8/eVuiFPXpg+s+W+WuHW6FdgoMKQZGCcmJxuZmySnGZgkJSVZWppZGJtaJBsZJRonGVukPVn3KrUhkJGh36GDiZEBAkF8TobsxLz8/LzEggIGBgBoIyNM',
// this.channelName,

// });
// final String? agoraToken;
// final String? channelName;
// @override
// State<VideoCallScreen> createState() => _VideoCallScreenState();
// }
// class _VideoCallScreenState extends State<VideoCallScreen> {
// int? _remoteUid;
// bool _localUserJoined = false;
// late RtcEngine _engine;
// bool _isMuted = false;
// bool _isVideoMuted = false;
// bool _isFrontCamera = true;
// @override
// void initState() {
// initAgora();
// print('${widget.channelName!}video');
// super.initState();
// }
// Future<void> initAgora() async {
// // Request permissions
// var statusMicrophone = await Permission.microphone.request();
// var statusCamera = await Permission.camera.request();
// // Check if permissions are granted
// if (!statusMicrophone.isGranted || !statusCamera.isGranted) {
// Fluttertoast.showToast(msg: 'Please grant camera and mic permissions!');
// // If permissions are not granted, pop from the screen
// Navigator.pop(context);
// return;
// }
// final String agoraAppId = dotenv.env['AGORA_APP_ID']!;
// //create the engine
// _engine = createAgoraRtcEngine();
// await _engine.initialize(RtcEngineContext(
// appId: agoraAppId,
// channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
// ));
// _engine.registerEventHandler(
// RtcEngineEventHandler(
// onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
// debugPrint("local user ${connection.localUid} joined");
// setState(() {
// _localUserJoined = true;
// });
// },
// onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
// debugPrint("remote user $remoteUid joined");
// setState(() {
// _remoteUid = remoteUid;
// });
// },
// onUserOffline: (RtcConnection connection, int remoteUid,
// UserOfflineReasonType reason) {
// debugPrint("remote user $remoteUid left channel");
// setState(() {
// Navigator.pop(context);
// _remoteUid = null;
// });
// },
// onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
// debugPrint(
// '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');

// },
// ),
// );
// await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
// await _engine.enableVideo();
// await _engine.startPreview();
// await _engine.joinChannel(
// token: "",
// channelId: '${widget.channelName!}video',
// uid: 0,
// options: const ChannelMediaOptions(),
// );
// }
// // Display remote user's video
// Widget _remoteVideo() {
// if (_remoteUid != null) {
// return Stack(
// children: [
// AgoraVideoView(
// controller: VideoViewController.remote(
// rtcEngine: _engine,
// canvas: VideoCanvas(uid: _remoteUid),
// connection:
// RtcConnection(channelId: '${widget.channelName!}video'),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(15),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// InkWell(
// onTap: () {
// Navigator.pop(context);
// },
// child: Icon(
// Icons.arrow_back,
// color: Colors.white,
// shadows: [
// Shadow(
// color: Colors.grey.withOpacity(0.5), // Shadow color
// blurRadius: 7, // Blur radius
// offset: const Offset(0, 3), // Offset of the shadow)
// )
// ],
// ),
// ),
// const Text(
// "End-to-end encrypted",
// style: TextStyle(
// color: Colors.white60,
// fontWeight: FontWeight.w400,
// fontSize: 14),
// ),
// const SizedBox()
// ],
// ),
// ),
// ],
// );
// } else {
// return Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// InkWell(
// onTap: () {
// Navigator.pop(context);
// },
// child: Icon(
// Icons.arrow_back,
// color: Colors.white,
// shadows: [
// Shadow(
// color: Colors.grey.withOpacity(0.5), // Shadow color
// blurRadius: 7, // Blur radius
// offset: const Offset(0, 3), // Offset of the shadow)
// )
// ],
// ),
// ),
// const Text(
// "End-to-end encrypted",
// style: TextStyle(
// color: Colors.white60,
// fontWeight: FontWeight.w400,
// fontSize: 14),
// ),
// const SizedBox()
// ],
// ),
// ),
// const SizedBox(
// height: 30,
// ),
// // Text(
// // widget.na!,

// // style: const TextStyle(
// // color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
// // ),
// const SizedBox(
// height: 50,
// ),
// // Container(
// // height: 180,
// // width: 180,
// // clipBehavior: Clip.antiAliasWithSaveLayer,
// // decoration: BoxDecoration(
// // borderRadius: BorderRadius.circular(100),
// // image: DecorationImage(
// // fit: BoxFit.cover,
// // image: NetworkImage(

// // ),
// // )),
// // ),
// const Spacer()
// ],
// );
// }
// }
// @override
// void dispose() {
// super.dispose();
// _dispose();
// }
// Future<void> _dispose() async {
// await _engine.leaveChannel();
// await _engine.release();
// }
// void _toggleMute() {
// setState(() {
// _isMuted = !_isMuted;
// });
// _engine.muteLocalAudioStream(_isMuted);
// }
// void _toggleVideoMute() {
// setState(() {
// _isVideoMuted = !_isVideoMuted;
// });
// _engine.muteLocalVideoStream(_isVideoMuted);
// }
// void _endCall() async {
// Navigator.pop(context);
// await _engine.leaveChannel();
// }
// void _switchCamera() {
// _engine.switchCamera();
// setState(() {
// _isFrontCamera = !_isFrontCamera;
// });
// }
// final GlobalKey _containerKey = GlobalKey();
// Offset _position = const Offset(0.0, 0.0);
// // Create UI with local view and remote view
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// backgroundColor: Colors.black,
// // appBar: AppBar(
// // title: const Text('Agora Video Call'),
// // ),
// body: SafeArea(
// child: Stack(
// children: [
// Center(
// child: _remoteVideo(),
// ),
// Positioned(
// left: math.max(
// 0,
// math.min(
// _position.dx, MediaQuery.of(context).size.width - 120)),
// top: math.max(
// 0,
// math.min(
// _position.dy, MediaQuery.of(context).size.height - 300)),
// child: Draggable(
// onDraggableCanceled: (velocity, offset) {
// setState(() {
// _position = offset;
// });
// },
// feedback: Container(
// key: _containerKey,
// width: 100,
// height: 150,
// clipBehavior: Clip.antiAliasWithSaveLayer,
// decoration:
// BoxDecoration(borderRadius: BorderRadius.circular(10)),
// child: _localUserJoined
// ? _isVideoMuted == false
// ? AgoraVideoView(
// controller: VideoViewController(
// rtcEngine: _engine,
// canvas: const VideoCanvas(uid: 0),
// ),
// )
// : Container(
// width: 100,
// height: 150,
// color: Colors.grey,
// child: const Icon(
// Icons.person,
// size: 50,
// ),
// )
// : const Center(
// child: CircularProgressIndicator(),
// ),
// ),
// child: Container(
// key: _containerKey,
// width: 100,
// height: 150,
// clipBehavior: Clip.antiAliasWithSaveLayer,
// decoration:
// BoxDecoration(borderRadius: BorderRadius.circular(10)),
// child: _localUserJoined
// ? _isVideoMuted == false
// ? AgoraVideoView(
// controller: VideoViewController(
// rtcEngine: _engine,
// canvas: const VideoCanvas(uid: 0),
// ),
// )
// : Container(
// width: 100,
// height: 150,
// color: Colors.grey,
// child: const Icon(
// Icons.person,
// size: 50,
// ),
// )
// : const Center(child: CircularProgressIndicator()),
// ),
// ),
// ),
// Align(
// alignment: Alignment.bottomCenter,
// child: Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// GestureDetector(
// onTap: _toggleMute,
// child: Container(
// height: 50,
// width: 50,
// padding: const EdgeInsets.all(8),
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.15),
// spreadRadius: 3,
// blurRadius: 10,
// offset: const Offset(0, 3),
// ),
// ],
// color: Colors.blue,
// borderRadius: BorderRadius.circular(100)),
// child: Icon(
// _isMuted ? Icons.mic_off : Icons.mic,
// size: 25,
// weight: 40,
// color: Colors.white,
// ),
// ),
// ),
// GestureDetector(
// onTap: _toggleVideoMute,
// child: Container(
// height: 50,
// width: 50,
// padding: const EdgeInsets.all(8),
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.15),
// spreadRadius: 3,
// blurRadius: 10,
// offset: const Offset(0, 3),
// ),
// ],
// color: Colors.blue,
// borderRadius: BorderRadius.circular(100)),
// child: Icon(
// _isVideoMuted
// ? Icons.videocam_off_rounded
// : Icons.videocam_rounded,
// size: 25,
// weight: 40,
// color: Colors.white,
// ),
// ),
// ),
// GestureDetector(
// onTap: _switchCamera,
// child: Container(
// height: 50,
// width: 50,
// padding: const EdgeInsets.all(8),
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.15),
// spreadRadius: 3,
// blurRadius: 10,
// offset: const Offset(0, 3),
// ),
// ],
// color: Colors.blue,
// borderRadius: BorderRadius.circular(100)),
// child: const Icon(
// Icons.cameraswitch_outlined,
// size: 25,
// weight: 40,
// color: Colors.white,
// ),
// ),
// ),
// GestureDetector(
// onTap: _endCall,
// child: Container(
// height: 50,
// width: 50,
// padding: const EdgeInsets.all(8),
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.15),
// spreadRadius: 3,
// blurRadius: 10,
// offset: const Offset(0, 3),
// ),
// ],
// color: Colors.red,
// borderRadius: BorderRadius.circular(100)),
// child: const Icon(
// Icons.call_end,
// size: 25,
// weight: 40,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// );
// }
// }