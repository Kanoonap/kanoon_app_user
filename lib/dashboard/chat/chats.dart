// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanoon_app/dashboard/chat/chat_screen.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Chats extends StatefulWidget {
//   const Chats({super.key});

//   @override
//   State<Chats> createState() => _ChatsState();
// }

// class _ChatsState extends State<Chats> {
//   String searchText = "";
//   TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 13,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 20.heightBox,
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Chats',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 23.heightBox,
//                 Container(
//                   height: 48,
//                   width: Get.size.width,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF6F7F9),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: searchController,
//                           cursorColor: Colors.amber,
//                           decoration: InputDecoration(
//                             prefixIcon: (searchText.isEmpty)
//                                 ? const Icon(Icons.search)
//                                 : IconButton(
//                                     icon: const Icon(Icons.clear),
//                                     onPressed: () {
//                                       searchText = '';
//                                       searchController.clear();
//                                       setState(() {});
//                                     },
//                                   ),
//                             hintText: 'Search by name',
//                             border: InputBorder.none,
//                             hintStyle: const TextStyle(
//                               fontSize: 14,
//                               // color: const Color(0xFF353535),
//                             ),
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               searchText = value;
//                             });
//                           },
//                         ),
//                       ),
//                       // Image.asset(
//                       //   'assets/filter.png',
//                       //   height: 20,
//                       //   width: 20,
//                       // ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('lawyers')
//                         .orderBy('name')
//                         // .where( 'groupId' ,isEqualTo: FirebaseAuth.instance.currentUser!.uid )
//                         .startAt([searchText.toUpperCase()]).endAt(
//                             ['$searchText\uf8ff']).snapshots(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(
//                             child: Padding(
//                           padding: EdgeInsets.only(top: 233),
//                           child: CircularProgressIndicator(),
//                         ));
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (!snapshot.hasData ||
//                           snapshot.data!.docs.isEmpty) {
//                         return Center(
//                             child: Padding(
//                           padding: const EdgeInsets.only(top: 233),
//                           child: Text(
//                             'No lawyer Registered yet',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.amber.shade700),
//                           ),
//                         ));
//                       } else {
//                         return Column(
//                             children: snapshot.data?.docs.map((e) {
//                                   String fcmToken = '';
//                                   try {
//                                     fcmToken = e['fcmToken'];
//                                   } catch (e) {
//                                     fcmToken = '';
//                                   }
//                                   return Column(
//                                     children: [
//                                       Card(
//                                         shadowColor: Colors.black,
//                                         color: Colors.white,
//                                         elevation: 13,
//                                         child: Container(
//                                           padding:
//                                               const EdgeInsets.only(left: 6),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                           ),
//                                           child: ListTile(
//                                             onTap: () {
//                                               Get.to(() => ChatScreen(
//                                                     fcmToken: fcmToken,
//                                                     groupId: FirebaseAuth
//                                                         .instance
//                                                         .currentUser!
//                                                         .uid,
//                                                     name: e['name'],
//                                                     image: e['image'],
//                                                     uid: e['lawyerId'],
//                                                   ));
//                                             },
//                                             contentPadding: EdgeInsets.zero,
//                                             leading: CircleAvatar(
//                                               radius: 30,
//                                               backgroundImage:
//                                                   NetworkImage(e['image']),
//                                             ),
//                                             title: Text(
//                                               e['name'],
//                                               style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             subtitle: const Text(
//                                               'Hi There',
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                             trailing: const Padding(
//                                               padding: EdgeInsets.only(
//                                                 right: 10,
//                                               ),
//                                               child: Text(
//                                                 '10:03 AM',
//                                                 // style: GoogleFonts.poppins(),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }).toList() ??
//                                 []);
//                       }
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'chat_screen.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final iv = encrypt.IV.fromLength(16);
  encrypt.Encrypter? encrypter;
  // 
  
  String searchText = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:   const Text(
                    'Chats',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.024, vertical: Get.height * 0.01),
          child: Column(
            children: [
              // Center(
              //   child: Text(
              //     'Recent',
              //     style: kBody1MediumBlue,
              //   ),
              // ),
              11.heightBox,
               Container(
                  height: 48,
                  width: Get.size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7F9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                            prefixIcon: (searchText.isEmpty)
                                ? const Icon(Icons.search)
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      searchText = '';
                                      searchController.clear();
                                      setState(() {});
                                    },
                                  ),
                            hintText: 'Search by name',
                            border: InputBorder.none,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              // color: const Color(0xFF353535),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          },
                        ),
                      ),])),
              
              const SizedBox(height: 10),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .orderBy('timeStamp', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Padding(
                        padding: EdgeInsets.only(top: 255),
                        child: CircularProgressIndicator(),
                      ));
                    }
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    QuerySnapshot chatSnapshot = snapshot.data as QuerySnapshot;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: chatSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          final chatData = snapshot.data?.docs[index].data()
                              as Map<String, dynamic>;
                          dynamic group = chatData['group'];
                          List<dynamic> groupIds = group.toList();

                          String targetUserId1 = groupIds[0];
                          String targetUserId2 =
                              groupIds.length > 1 ? groupIds[1] : "";
                          groupIds
                              .remove(FirebaseAuth.instance.currentUser!.uid);
                          return targetUserId1 ==
                                      FirebaseAuth.instance.currentUser!.uid ||
                                  targetUserId2 ==
                                      FirebaseAuth.instance.currentUser!.uid
                              ? FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('lawyers')
                                      .doc(groupIds[0])
                                      .get(),
                                  builder: (context, userData) {
                                    if (userData.hasError ||
                                        !userData.hasData ||
                                        !userData.data!.exists) {
                                      return const SizedBox();
                                    }
                                    final targetUser = userData.data;
                                    if (targetUser == null) {
                                      return const SizedBox();
                                    }
                                    return  
                                    
                                     Card(
                                      shadowColor: Colors.black,
                                      color: Colors.white,
                                      elevation: 13,
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: ListTile(                                               
                                          onTap: () {
                                            Get.to(() => ChatScreen(
                                                  fcmToken:
                                                      targetUser['fcmToken'],
                                                  name: targetUser['name'],
                                                  image: targetUser['image'],
                                                  uid: targetUser['lawyerId'],
                                                  groupId: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                ));
                                          },
                                          contentPadding: EdgeInsets.zero,
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                targetUser['image']),
                                          ),
                                          title: Text(
                                            targetUser['name'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          subtitle: Text(
      //  encrypter?.decrypt64(chatData['lastMessage'], iv: iv).toString()??'';

                                            chatData['lastMessage'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          trailing: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Text(
                                              
                                              chatData['timeStamp'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : const SizedBox();
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
