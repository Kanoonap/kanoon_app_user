import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/controllers/get_lawyer_controller.dart';
import 'package:kanoon_app/dashboard/lawyer_detail/book_lawyer_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../chat/chat_screen.dart';
import 'lawyer_schedule.dart';

class Details extends StatefulWidget {
  final String image;
  final String name;
  final String category;
  final String experience;
  final String? fcmToken;
  final String? uid;
  final String address;
  final String contact;
  final String practice;
  final String bio;
  const Details({
    super.key,
    required this.image,
    required this.name,
    required this.category,
    required this.experience,
    required this.address,
    required this.contact,
    this.fcmToken,
    this.uid,
    required this.practice,
    required this.bio,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
   double? _rating;
  bool _ratingExists = false;
  final CollectionReference lawyersCollection =
      FirebaseFirestore.instance.collection('lawyers');
  @override
  void initState() {
    super.initState();
    _checkRating();
  }

  Future<void> _checkRating() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('lawyers')
            .doc(widget.uid)
            .get();

    if (snapshot.exists) {
      setState(() {
        _rating = snapshot.data()!['rating'];
        _ratingExists = true;
      });
    }
  }

  Future<void> _submitRating(double rating) async {
    await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(widget.uid)
        .set({'rating': rating},SetOptions(merge: true));
    setState(() {
      _rating = rating;
      _ratingExists = true;
    });
  }

  LawyerCOntroller lawyerCOntroller = Get.put(LawyerCOntroller());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    // final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
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
                SizedBox(width: Get.width * .3),
                const Text(
                  'About',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 12,
            ),
            Stack(
              children: [
                SizedBox(
                  height: Get.height * .32,
                  width: Get.size.width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        // topLeft: Radius.circular(30),
                        // topRight: Radius.circular(30),
                        ),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: height * .41,
                  margin: EdgeInsets.only(top: height * .28),
                  padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Container(
                        width: 30,
                        height: 8,
                        margin: const EdgeInsets.only(
                          left: 120,
                          right: 120,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            3,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // 170.widthBox,
                          // const Text(
                          //   '4.7',
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     color: Colors.black87,
                          //     fontWeight: FontWeight.w700,
                          //   ),
                          // ),
                          // const Icon(
                          //   Icons.star,
                          //   size: 16,
                          //   color: Colors.amber,
                          // ),
          
                _ratingExists
                ? Column(
                    children: [
                      Text(
                        'Rating: $_rating',
                        style: const TextStyle( fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,),
                      ),
                      RatingBar.builder(
                        initialRating: _rating?.toDouble()??0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating)async {
                           final newRating = await showDialog<double>(
                        context: context,
                        builder: (context) {
                          double rating = 0.0;
                          return AlertDialog(
                            title: const Text('Rate this lawyer'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 40,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (newRating) {
                                    rating = newRating;
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(rating);
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          );
                        },
                      );

                      if (newRating != null) {
                        await _submitRating(newRating);
                      }
                        },
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () async {
                      final newRating = await showDialog<double>(
                        context: context,
                        builder: (context) {
                          double rating = 0.0;
                          return AlertDialog(
                            title: const Text('Rate this lawyer'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 40,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (newRating) {
                                    rating = newRating;
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(rating);
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          );
                        },
                      );

                      if (newRating != null) {
                        await _submitRating(newRating);
                      }
                    },
                    child: const Text('Rate this lawyer'),
                  ),
                        ],
                      ),
                      5.heightBox,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Area of Practice',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          // Text(
                          //   '138Reviews',
                          //   style: TextStyle(
                          //     fontSize: 13,
                          //     color: Colors.black87,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 26,
                            width: 126,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.practice,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ),
                          10.widthBox,
                          Container(
                            height: 26,
                            width: 126,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${widget.category} lawyer',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 26,
                      //       width: 126,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         border: Border.all(
                      //           color: Colors.black,
                      //           width: 1,
                      //         ),
                      //       ),
                      //       child: Center(
                      //         child: Text(
                      //           widget.category,
                      //           style: TextStyle(
                      //             fontSize: 12,
                      //             color: Colors.grey[800],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: height * .02,
                      ),
                      const Text(
                        'Biography',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.bio,
                        style:  const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      18.heightBox,
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 14,
                            color: Colors.black,
                          ),
                          10.widthBox,
                          Text(
                            widget.address,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          const Icon(
                            Icons.work,
                            size: 14,
                            color: Colors.black,
                          ),
                          10.widthBox,
                          Text(
                            widget.experience,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          const Icon(
                            Icons.language,
                            size: 14,
                            color: Colors.black,
                          ),
                          10.widthBox,
                          Text(
                            widget.contact,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.to(() => ChatScreen(
                            fcmToken: widget.fcmToken,
                            groupId: FirebaseAuth.instance.currentUser!.uid,
                            name: widget.name,
                            image: widget.image,
                            uid: widget.uid,
                          ));
                    },
                    child: Container(
                      height: 49,
                      width: Get.width * .4,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Continue chat',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.to(() => ScheduleScreen(
                            lawyerId: widget.uid.toString(),
                          ));
                    },
                    child: Container(
                      width: Get.width * .4,
                      height: 49,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Availability',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => LawyerBookingScreen(
                      lawyerId: widget.uid.toString(),
                      name: widget.name,
                      image: widget.image,
                    )); // showAlertDialog(context);
              },
              child: Container(
                height: 49,
                width: Get.size.width,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Book Appointment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<double?> showRatingDialog(BuildContext context) async {
    return showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        double userRating = 0;
        return AlertDialog(
          title: const Text('Rate this lawyer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please rate this lawyer'),
              Slider(
                value: userRating,
                min: 0,
                max: 5,
                divisions: 5,
                label: userRating.toString(),
                onChanged: (value) {
                  setState(() {
                    userRating = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(userRating);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
