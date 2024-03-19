import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/controllers/get_lawyer_controller.dart';
import 'package:kanoon_app/dashboard/lawyer_detail/detail_lawyer.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  LawyerCOntroller lawyerCOntroller = Get.put(LawyerCOntroller());
  TextEditingController searchController = TextEditingController();

  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * .24),
                    Text(
                      widget.category,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                22.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: searchController,
                            cursorColor: Colors.amber,
                            decoration: InputDecoration(
                              hintText: 'Search for lawyers',
                              border: InputBorder.none,
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
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                // color: const Color(0xFF353535),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            }),
                      ),
                      Image.asset(
                        'assets/filter.png',
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 12,
                // ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                //   width: 180,
                //   height: 25,
                //   decoration: ShapeDecoration(
                //     shape: RoundedRectangleBorder(
                //       side: const BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //   ),
                //   child: const Text(
                //     'All Lawyers+ 10 years',
                //     style: TextStyle(
                //       color: Color(0xFF535353),
                //       fontSize: 10,
                //       fontFamily: 'Poppins',
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10),

                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('lawyers')
                        .orderBy('name')
                        .where('category', isEqualTo: widget.category)
                        .startAt([searchText.toUpperCase()]).endAt(
                            ['$searchText\uf8ff']).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 233),
                          child: CircularProgressIndicator(),
                        ));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 233),
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
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            final e = snapshot.data!.docs[index];
                            if (e["name"]
                                .toString()
                                .toLowerCase()
                                .contains(searchText.toLowerCase())) {
                                  
                              String fcmToken = '';
                              try {
                                fcmToken = e['fcmToken'];
                              } catch (e) {
                                fcmToken = '';
                              }
                              return Card(
                                  shadowColor: Colors.black,
                                  color: Colors.white,
                                  elevation: 13,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 76,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        e['image']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 2),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                e['name'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Text(
                                                                e['category'], // Replace with your experience text
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 2),
                                                          child: Column(
                                                            children: [
                                                              const Text(
                                                                'Exp',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF0C253F),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${e['experience']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // const Row(
                                                              //   children: [
                                                              //     Text(
                                                              //       '4.0 ', // Replace with your rating value
                                                              //       style: TextStyle(fontSize: 12),
                                                              //     ),
                                                              //     Icon(Icons.star,
                                                              //         size: 16,
                                                              //         color: Colors.amber),
                                                              //   ],
                                                              // ),
                                                              // const Text(
                                                              //   'Free',
                                                              //   style: TextStyle(
                                                              //     color: Color(0xFF3C5065),
                                                              //     fontSize: 12,
                                                              //     fontFamily: 'Poppins',
                                                              //     fontWeight: FontWeight.w600,
                                                              //     letterSpacing: 0.18,
                                                              //   ),
                                                              // ),
                                                              const SizedBox(
                                                                height: 11,
                                                              ),

                                                              GestureDetector(
                                                                onTap: () {
                                                                  Get.to(() => Details(
                                                                      fcmToken:
                                                                          fcmToken,
                                                                      uid: e[
                                                                          'lawyerId'],
                                                                      image: e[
                                                                          'image'],
                                                                      name: e[
                                                                          'name'],
                                                                      category: e[
                                                                          'category'],
                                                                      experience: e[
                                                                          'experience'],
                                                                      address: e[
                                                                          'address'],
                                                                      contact: e[
                                                                          'contact'], practice: e['practice'], bio: e['bio'],));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 82,
                                                                  height: 28,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .amber,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      'Book Now',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
