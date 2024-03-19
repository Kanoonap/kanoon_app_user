import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/authentication/sign_in_screen.dart';
import 'package:kanoon_app/controllers/auth_controller.dart';
import 'package:kanoon_app/controllers/notification.dart';
import 'package:kanoon_app/dashboard/dashboard.dart';
import 'package:kanoon_app/widgets/primary_textfield.dart';
import 'package:velocity_x/velocity_x.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  LocalNotificationService localNotificationService =
      LocalNotificationService();
  bool loading = false;

  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultButtonColor = Colors.amber;
    const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                18.heightBox,
                const Text(
                  'Create Account',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Let’s create account together',
                  style: TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                20.heightBox,
                Center(
                  child: Obx(
                    () => authController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () async {
                              authController.pickImage(context);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color:
                                      const Color.fromARGB(255, 231, 231, 231),
                                  image: authController.image == null
                                      ? const DecorationImage(
                                          image:
                                              AssetImage('assets/profile.png'))
                                      : DecorationImage(
                                          image: FileImage(
                                            File(authController.image!.path)
                                                .absolute,
                                          ),
                                          fit: BoxFit.cover)),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Name',
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
                      controller: nameController,
                      text: 'Enter your name',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    10.heightBox,
                    const Text(
                      'Email',
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
                      controller: emailController,
                      text: 'Enter your email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    // TextFormField(controller: emailController,),
                    10.heightBox,
                    const Text(
                      'Password',
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
                        obsecure: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _togglePasswordVisibility,
                        ),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                        controller: passwordController,
                        text: 'Enter your password'),
                    10.heightBox,
                    const Text(
                      'Address',
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
                      text: 'Enter Your Address',
                      controller: addressController,
                      prefixIcon: const Icon(
                        Icons.location_pin,
                        color: Colors.black,
                      ),
                    ),
                    10.heightBox,
                    const Text(
                      'City',
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
                      text: 'Enter your city',
                      controller: cityController,
                      prefixIcon: const Icon(
                        Icons.location_city_sharp,
                        color: Colors.black,
                      ),
                    ),
                    70.heightBox,
                    Center(
                      child: Stack(
                        children: [          
                          InkWell(
                            onTap: () async {
                              try {
                                String name = nameController.text.trim();
                                String email = emailController.text.trim();
                                String city = cityController.text.trim();
                                String address = addressController.text.trim();
                                String password =
                                    passwordController.text.trim();

                                if (
                                  authController.image==null||
                                  
                                  name.isEmpty ||
                                    emailController.text.trim().isEmpty ||
                                    address.isEmpty ||
                                    city.isEmpty ||
                                    password.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Please enter all details",
                                  );
                                } else{
                                  authController.createUser(email: email, name: name, 
                                  password: password, city: city, address: address,
                                   context: context);
                                
                                  // showModal();
                                }
                              } catch (e) {
                                Get.snackbar(
                                  "Error",
                                  e.toString(),
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 349 * 12,
                              decoration: BoxDecoration(
                                color: loading
                                    ? loadingButtonColor
                                    : defaultButtonColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Visibility(
                                  visible: !loading,
                                  child: const Text(
                                    'Sign Up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (loading)
                            const Positioned.fill(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 14,
                // ),
                // Container(
                //   width: Get.size.width,
                //   height: 56,
                //   padding: const EdgeInsets.all(16),
                //   decoration: ShapeDecoration(
                //     shape: RoundedRectangleBorder(
                //       side:
                //           const BorderSide(width: 1, color: Color(0xFFCECECE)),
                //       borderRadius: BorderRadius.circular(14),
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset('assets/google.png'),
                //       const SizedBox(width: 10),
                //       const Text(
                //         'Sign in with google',
                //         style: TextStyle(
                //           color: Color(0xFFCECECE),
                //           fontSize: 16,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 22,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const SigninScreen());
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Color(0xFF828A89),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFFFFC100),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.infinity,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/tick.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Congratulations, you have successfully created your account on Kanoon App.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Dashboard()));
      // Navigator.of(context).pop();
    });
  }
}
