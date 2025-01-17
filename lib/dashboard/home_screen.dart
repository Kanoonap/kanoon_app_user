// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/controllers/get_lawyer_controller.dart';
import 'package:kanoon_app/dashboard/lawyer_detail/all_lawyers.dart';
import 'package:kanoon_app/dashboard/category/virtual_chamber.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/profile_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   String searchText = "";
  TextEditingController searchController = TextEditingController();
  ProfileController profileController = Get.put(
    ProfileController(),
  );
  LawyerCOntroller lawyerCOntroller = Get.put(
    LawyerCOntroller(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                 
                                         
                    StreamBuilder(
                        stream: profileController.allUsers(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }  else {
                          return Column(
                              children: snapshot.data?.docs.map((e) {
                                    return Column(
                                      children: [
                                        e["userId"] ==
                                                FirebaseAuth
                                                    .instance.currentUser?.uid
                                            ? Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: 
                                                        NetworkImage(
                                                            e['image']),
                                                  ),
                                                  const SizedBox(width: 12,),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Hello,',
                                                        style: TextStyle(
                                                          color: Color(
                                                              0xFF0C253F),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        e['username'],
                                                        style:
                                                            const TextStyle(
                                                          color: Color(
                                                              0xFF5A5A5A),
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  }).toList() ??
                                  []);
  }}),
                  
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.notification_add,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
                10.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  width: 327 * 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.grey,
                    ),
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
                      ),
                      // Image.asset(
                      //   'assets/filter.png',
                      //   height: 20,
                      //   width: 20,
                      // ),
                    ],
                  ),
                ),
                10.heightBox,
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Free Consulation",
                      style: TextStyle(
                        color: Color(0xFF474747),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=>const AllLawyers());
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          color: Color(0xFFF4D44E),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                5.heightBox,
                SizedBox(
                  height: 128,
                  child: StreamBuilder(
                      stream:  FirebaseFirestore.instance
                        .collection('lawyers').limit(4)
                        .orderBy('name')
                        .startAt([searchText.toUpperCase()]).endAt(
                            ['$searchText\uf8ff']).snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: CircularProgressIndicator(),
                        ));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'No lawyer Registered yet',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.amber.shade700),
                          ),
                        ));
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          // itemCount:snapshot.data!.docs.length
                          // <
                          //                         3
                          //                     ? snapshot.data!.docs.length
                          //                     : 3,
                          itemCount: snapshot.data?.docs.length ?? 0,

                          itemBuilder: (context, index) {
                            final e = snapshot.data!.docs[index];
                            return Card(
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: 8,
                                ),
                                height: 120,
                                width: 220,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          e['image'],
                                          fit: BoxFit.cover,
                                          height: 75,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 6,
                                        top: 9
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              
                                              Text(
                                                e['name'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // 5.widthBox,
                                              // Text(
                                              //   '4.7',
                                              //   style: GoogleFonts.poppins(
                                              //     color: Colors.black,
                                              //     fontSize: 12,
                                              //     fontWeight: FontWeight.bold,
                                              //   ),
                                              // ),
                                              // const Icon(
                                              //   Icons.star,
                                              //   color: Colors.amber,
                                              // ),
                                            ],
                                          ),
                                          2.heightBox,
                                          Text(
                                            e['category'],
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                           Row(
                                             children: [
                                               const Text(
                                                'Price',
                                                 style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 12,
                                                   fontWeight: FontWeight.w600,
                                                 ),
                                               ),
                                               const SizedBox(
                                                width: 33,
                                               ),
                                                 Text(
                                            e['price'],
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 11,
                                            ),
                                          ),
                                             ],
                                           ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
    }  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        color: Color(0xFF474747),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CategoryScreen()));
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          color: Color(0xFFF4D44E),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 60.53,
                          height: 68,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/labor.png',
                                  height: 47.56,
                                  width: 53.85,
                                ),
                              ),
                              const Divider(),
                              const Text(
                                'Labour lawyers',
                                style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 7,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 60.53,
                          height: 70,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/divorce.png',
                                  height: 48.56,
                                  width: 53.85,
                                ),
                              ),
                              const Divider(),
                              const Text(
                                'Divorce lawyers',
                                style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 60.53,
                          height: 68,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/civil.png',
                                  height: 47.56,
                                  width: 53.85,
                                ),
                              ),
                              const Divider(),
                              const Text(
                                'Civil lawyers',
                                style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 7,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 60.53,
                          height: 68,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/family.png',
                                  height: 47.56,
                                  width: 53.85,
                                ),
                              ),
                              const Divider(),
                              const Text(
                                'Family lawyers',
                                style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 60.53,
                          height: 68,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/military.png',
                                  height: 47.56,
                                  width: 53.85,
                                ),
                              ),
                              const Divider(),
                              const Text(
                                'Military lawyers',
                                style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 6.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 60.53,
                          height: 68,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/criminal.png',
                                  height: 47.56,
                                  width: 53.85,
                                ),
                              ),
                              const Divider(),
                              const Text(
                                'Criminal lawyers',
                                style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 6.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.heightBox,
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AllLawyers()));
                    },
                    child: Container(
                      height: 34,
                      width: 167,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'All Lawyer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                20.heightBox,
                Stack(
                  children: [
                    Container(
                      height: 176,
                      width: 328,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Chat with experts ',
                                  style: TextStyle(
                                    color: Color(0xFFF6FAFC),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  'Access to Expertise',
                                  style: TextStyle(
                                    color: Color(0xFFF6FAFC),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  'Convenient',
                                  style: TextStyle(
                                    color: Color(0xFFF6FAFC),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  'Time-Saving',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const Text(
                                  'Confidential',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                10.heightBox,
                                Container(
                                  height: 26,
                                  width: 93,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Chat Now',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Adjust the spacing as needed
                            // Expanded(
                            //   flex: 1,
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(16),
                            //     child: Image.asset(
                            //       'assets/person.png',
                            //       height: 250,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    10.widthBox,
                    Positioned(
                      right: -92, // Adjust the position as needed
                      top: 2,
                      left: 190, // Adjust the position as needed
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/person.png',
                          width: 244, // Adjust the width as needed
                          height: 207, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
