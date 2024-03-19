import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/controllers/auth_controller.dart';
import 'package:kanoon_app/dashboard/lawyer_detail/search_lawyers.dart';
import 'package:kanoon_app/dashboard/notification_screen.dart';
import '../controllers/data_controller.dart';
import '../controllers/notification.dart';
import 'chat/chats.dart';
import 'home_screen.dart';
import 'profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin<Dashboard> {
  int selectedIndex = 0;
   LocalNotificationService localNotificationService=LocalNotificationService();
   AuthController authController=Get.put(AuthController());
 @override
  void initState() {
    super.initState();
    Get.put(DataController(), permanent: true);

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
  localNotificationService.requestNotificationPermission();
    localNotificationService.forgroundMessage();
    localNotificationService.firebaseInit(context);
    localNotificationService.setupInteractMessage(context);
    localNotificationService.isTokenRefresh();
    LocalNotificationService.storeToken();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          selectedIndex = 0;
          setState(() {});
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: const [
            HomeScreen(),
            MessageView(),
            UserNotificationScreen(),
            SearchLawyers(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.7),
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
          unselectedLabelStyle: const TextStyle(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home.png',height: 24,
                color: selectedIndex == 0 ? Colors.black : Colors.grey.shade400,
              ),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/chats.png',height: 24,
                color: selectedIndex == 1 ? Colors.black : null,
              ),
              label: 'Chats',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/notification.png',height: 24,
                color: selectedIndex == 2 ? Colors.black : null,
              ),
              label: 'Notifications',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/search.png',height: 24,
                color: selectedIndex == 3 ? Colors.black : null,
              ),
              backgroundColor: Colors.black,
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/profile.png',height: 24,
                color: selectedIndex == 4 ? Colors.black : null,
              ),
              backgroundColor: Colors.black,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
