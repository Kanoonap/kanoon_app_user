import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'authentication/sign_in_screen.dart';
import 'dashboard/dashboard.dart';
import 'onboard_screens/onboarding_screen.dart';
import 'utils/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? users;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.to(() => const AuthGate());
    });
    _getCurrentLocation();
    _checkAuthentication();
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
    double distanceInMeters = Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      latitude.toDouble(),
      longitude.toDouble(),
    );
    //
    //

    if (distanceInMeters > 20000) {
      await _auth.signOut();
      Get.to(() => const OnboardingScreens());
    } else {
      Get.to(() => const Dashboard());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 200,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
