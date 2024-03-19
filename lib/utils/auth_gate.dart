import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:kanoon_app/dashboard/dashboard.dart';
import 'package:kanoon_app/onboard_screens/onboarding_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../authentication/sign_in_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
 final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? users;
  late Position _currentPosition;

   @override
  void initState() {
    super.initState();
     Timer(const Duration(seconds: 3), () {
      
      Get.to(()=>AuthGate());
    });
    // _getCurrentLocation();
    // _checkAuthentication();
  }

  void _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
 void _checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        await _checkUserLocation();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SigninScreen()),
        );
      }
    });
  }

  Future<void> _checkUserLocation() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    String latitude = documentSnapshot.get('latitude');
    String longitude = documentSnapshot.get('longitude');
    double distanceInMeters = await Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      latitude.toDouble(),
      longitude.toDouble(),
    );
    // 
    // 
    
    if (distanceInMeters > 5000) {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreens()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Dashboard();
          } else {
            return const OnboardingScreens();
          }
        },
      ),
    );
  }
}
