import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/splash.dart';

import 'controllers/notification.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    if (kDebugMode) {
      print(message.data.toString());
    }
  }
  if (kDebugMode) {
    print(message.notification!.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Stripe.publishableKey = "pk_test_51Oreru057vMPxoNy5tJpnBWMPH0L9XFHk7UHoqXpKa7j5Q11x4CBGW1jE5P7NpxwnRwOHUSE7c2lxdwyaQ308V1p00QEf2oHNM";

  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override                                 
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kanoon App',
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          // useMaterial3: true,
          ),
      home: const SplashScreen(),
    );
  }
}
