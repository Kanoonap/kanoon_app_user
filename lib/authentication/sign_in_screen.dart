import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/authentication/data_screen.dart';
import 'package:kanoon_app/authentication/forgot_password_screen.dart';
import 'package:kanoon_app/controllers/auth_controller.dart';
import 'package:kanoon_app/widgets/primary_textfield.dart';
import 'package:velocity_x/velocity_x.dart';

import '../dashboard/dashboard.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AuthController authController = Get.put(AuthController());
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
            padding: const EdgeInsets.all(16),
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
                36.heightBox,
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 32,
                    fontFamily: 'Switzer',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Welcome Back! Please Enter Your Details.',
                  style: TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 16,
                    fontFamily: 'Switzer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                24.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontFamily: 'Switzer',
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
                        fontFamily: 'Switzer',
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
                    26.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const ForgotPasswordScreen());
                          },
                          child: const Text(
                            'Forgot password',
                            style: TextStyle(
                              color: Color(0xFF828A89),
                              fontSize: 14,
                              fontFamily: 'Switzer',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    40.heightBox,
                    Center(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please enter all details",
                                );
                              } else {
                                await authController.loginUser(
                                    context, email, password);
                                // showModal();
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
                                    'Sign in',
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
                //           fontFamily: 'Poppins',
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
                    Get.to(() => const DataScreen());
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: TextStyle(
                          color: Color(0xFF828A89),
                          fontSize: 14,
                          fontFamily: 'Switzer',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Sign Up for free',
                        style: TextStyle(
                          color: Color(0xFFFFC100),
                          fontSize: 14,
                          fontFamily: 'Switzer',
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
                  'Congratulations, you have successfully Logged in Kanoon app.',
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

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Dashboard()));
      // Navigator.of(context).pop();
    });
  }
}
