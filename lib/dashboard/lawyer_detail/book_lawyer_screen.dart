import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanoon_app/widgets/primary_textfield.dart';
import 'package:ndialog/ndialog.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/user_model.dart';

class LawyerBookingScreen extends StatefulWidget {
  final String lawyerId;
  final String name;
  final String image;
  const LawyerBookingScreen(
      {super.key,
      required this.lawyerId,
      required this.name,
      required this.image});

  @override
  State<LawyerBookingScreen> createState() => _LawyerBookingScreenState();
}

class _LawyerBookingScreenState extends State<LawyerBookingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController caseTypeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  UserModel? userModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;

 

  void bookAppointment({
    required String caseType,
    required String cnic,
    required String name,
    required String date,
    required String time,
  }) async {
    ProgressDialog progressDialog =
        ProgressDialog(context, message: const Text('Please wait'), title: null);
    try {
      progressDialog.show();
      User? user = _auth.currentUser;
      String uid = user!.uid;
      var uuid = const Uuid();
      var myId = uuid.v6();
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final data = document.data()!;
      String userName = data['username'];
      String image = data['image'];
      //
      //
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(myId)
          .set({
        'caseId': myId,
        'userId': uid,
        'lawyerId': widget.lawyerId,
        'lawyerImage': widget.image,
        'lawyerName': widget.name,
        'name': userName,
        'image': image,
        'caseType': caseType,
        'cnic': cnic,
        'date': date,
        'time': time,
        'status': 'ongoing',
      });
      progressDialog.dismiss();
      Fluttertoast.showToast(msg: 'Booking successful');
    } catch (e) {
      progressDialog.dismiss();

      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              44.heightBox,
              Row(children: [
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
                SizedBox(width: Get.width * .2),
                const Text(
                  'Book a lawyer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
              55.heightBox,
              const Text(
                'Case type',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              PrimaryTextField(
                  controller: caseTypeController,
                  text: 'Case type',
                  prefixIcon: const Icon(
                    Icons.type_specimen,
                    size: 22,
                  )),
              10.heightBox,
              const Text(
                'Cnic No.',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: cnicController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.030,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Your cnic",
                  focusColor: Colors.black,
                  hintStyle: const TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              10.heightBox,
              const Text(
                'Select date',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.030,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Select a date",
                  focusColor: Colors.black,
                  hintStyle: const TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                    });
                  }
                },
              ),
              10.heightBox,
              const Text(
                'Select a time',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: timeController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.030,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Select a time",
                  focusColor: Colors.black,
                  hintStyle: const TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.watch_later,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      timeController.text = picked.format(context);
                    });
                  }
                },
              ),
              SizedBox(height: Get.height * .16),
              GestureDetector(
                onTap: () async {
                  String name = nameController.text.trim();
                  String date = dateController.text.trim();
                  String time = timeController.text.trim();
                  String caseType = caseTypeController.text.trim();
                  String cnic = cnicController.text.trim();
                  //
                  //

                  if (caseType.isEmpty || date.isEmpty || time.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please enter all details",
                    );
                  } else {
                    bookAppointment(
                        caseType: caseType,
                        cnic: cnic,
                        date: date,
                        time: time,
                        name: name);
                  }

                  caseTypeController.clear();
                  timeController.clear();
                  dateController.clear();
                  cnicController.clear();
                },
                child: Container(
                  height: 49,
                  width: Get.size.width,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
