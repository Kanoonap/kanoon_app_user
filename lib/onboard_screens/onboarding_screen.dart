
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/authentication/sign_in_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/auth_controller.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
 final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
   AuthController authController=Get.put(AuthController());
@override
  void initState() {

authController.getCurrentLocation();    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: const [
          Onboard1(),
          Onboard2(),
          Onboard3(),
        ],
      ),
      bottomSheet: _currentPage != 2
          ? 
          Container(
              color: Colors.grey[900],
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildDot(0),
                  buildDot(1),
                ],
              ),
            )
          : null,
    );
  }

  Widget buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == index ? const Color(0xFFFFC100) : Colors.grey,
        ),
      ),
    );
  }
}

class Onboard1 extends StatefulWidget {
  const Onboard1({super.key});

  @override
  State<Onboard1> createState() => _Onboard1State();
}

class _Onboard1State extends State<Onboard1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.,
        children: [
          // Full-screen background image
          Padding(
            padding: const EdgeInsets.only(
              bottom: 300,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/hamer.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 270,
            right: MediaQuery.of(context).size.width / -14,
            left: MediaQuery.of(context).size.width / -11,
            child: Container(
              height: 58,
              width: 612 * 436.25,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/ov.png',
                color: Colors.grey[900],
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    const Text(
                      "Don't need to go to court",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 193, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.heightBox,
                    Container(
                      width: 282.0, 
                      height: 115.0, 
                      alignment: Alignment
                          .center, 
                      padding: const EdgeInsets.only(
                        top: 2,
                        left: 8,
                        right: 8,
                      ), 
                      child: const Text(
                        'Kanoon helps lawyers enhance their practice and extend their influence by connecting them with clients who seek their expertise in a dynamic digital environment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontSize: 16.0,
                          // height: 26 / 18,
                          letterSpacing: -0.25,
                          color: Color(0xFFFFFFFF), // White color
                        ),
                        maxLines:
                            5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Onboard2 extends StatefulWidget {
  const Onboard2({super.key});

  @override
  State<Onboard2> createState() => _Onboard2State();
}

class _Onboard2State extends State<Onboard2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 300,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/onboard2.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 270,
            right: MediaQuery.of(context).size.width / -14,
            left: MediaQuery.of(context).size.width / -11,
            child: Container(
              height: 58,
              width: 612 * 436.25,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/ov.png',

                color: Colors.grey[900],
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    const Text(
                      "Find Your Lawyers easily",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    2.heightBox,
                    Container(
                      width: 282.0, 
                      height: 115.0,
                      alignment: Alignment
                          .center,
                      padding: const EdgeInsets.only(
                        top: 2,
                        left: 8,
                        right: 8,
                      ), //
                      child: const Text(
                        'Kanoon helps lawyers enhance their practice and extend their influence by connecting them with clients who seek their expertise in a dynamic digital environment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontSize: 16.0,
                          letterSpacing: -0.25,
                          color: Color(0xFFFFFFFF), 
                        ),
                        maxLines:
                            5,
                      ),
                    ),
                    60.heightBox,
                   
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class Onboard3 extends StatefulWidget {
  const Onboard3({super.key});

  @override
  State<Onboard3> createState() => _Onboard3State();
}

class _Onboard3State extends State<Onboard3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.,
        children: [
          // Full-screen background image
          Padding(
            padding: const EdgeInsets.only(
              bottom: 300,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/onboard3.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 270,
            right: MediaQuery.of(context).size.width / -14,
            left: MediaQuery.of(context).size.width / -11,
            child: Container(
              height: 58,
              width: 612 * 436.25,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/ov.png',

                color: Colors.grey[900],
                // color: Colors.grey[900],
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    const Text(
                      "Find Your Lawyers easily",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    2.heightBox,
                    Container(
                      width: 282.0, 
                      height: 115.0,
                      alignment: Alignment
                          .center,
                      padding: const EdgeInsets.only(
                        top: 2,
                        left: 8,
                        right: 8,
                      ), 
                      child: const Text(
                        'Kanoon helps lawyers enhance their practice and extend their influence by connecting them with clients who seek their expertise in a dynamic digital environment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontSize: 16.0,
                          letterSpacing: -0.25,
                          color: Color(0xFFFFFFFF), 
                        ),
                        maxLines:
                            5, 
                      ),
                    ),
                    60.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const SigninScreen());
                        },
                        child: Container(
                          width: 312.0,
                          height: 49.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
