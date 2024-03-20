import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kanoon_app/authentication/otp_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String verify = '';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  var phone = '';
  // final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: '92',
    countryCode: 'PK',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Pakistan',
    example: 'Pakistan',
    displayName: 'Pakistan',
    displayNameNoCountryCode: 'PK',
    e164Key: '',
  );

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultButtonColor = Colors.amber;
    const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                20.heightBox,
                const Divider(
                  color: Colors.grey,
                  height: 0.5,
                  thickness: 1,
                ),
                30.heightBox,
                const Text(
                  'Login/Registration',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                3.heightBox,
                const Text(
                  "Enter your phone number. We'll send you a verification code.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                40.heightBox,
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Text(
                        'Phone Number ',
                        style: TextStyle(
                          color: Color(0xFF36454F),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 6),
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      if (kDebugMode) {
                        print(number.phoneNumber);
                      }
                    },
                    onInputValidated: (bool value) {
                      if (kDebugMode) {
                        print(value);
                      }
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    textFieldController: phoneController,
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: InputBorder.none,
                    onSaved: (PhoneNumber number) {
                      if (kDebugMode) {
                        print('On Saved: $number');
                      }
                    },
                  ),
                ),

                // Form(
                //   key: _formKey,
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       left: 10,
                //       right: 10,
                //     ),
                //     child: TextFormField(
                //       cursorColor: Colors.black,
                //       controller: phoneController,
                //       style: const TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //       ),
                //       onChanged: (value) {
                //         setState(() {
                //           phoneController.text = value;
                //         });
                //       },
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.symmetric(
                //           vertical: MediaQuery.of(context).size.width * 0.030,
                //         ),
                //         filled: true,
                //         fillColor: Colors.grey[200],
                //         hintText: '3086024485',
                //         hintStyle: const TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w500,
                //           color: Colors.grey,
                //         ),
                //         border: InputBorder.none,
                //         // enabledBorder: OutlineInputBorder(
                //         //   borderRadius: BorderRadius.circular(10),
                //         //   borderSide: const BorderSide(color: Colors.black45),
                //         // ),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: const BorderSide(color: Colors.black45),
                //         ),
                //         prefixIcon: Container(
                //           padding: const EdgeInsets.only(
                //             top: 13,
                //             right: 9,
                //             left: 10,
                //           ),
                //           child: InkWell(
                //             onTap: () {
                //               showCountryPicker(
                //                 context: context,
                //                 countryListTheme: CountryListThemeData(
                //                   bottomSheetHeight: 550,
                //                   inputDecoration: InputDecoration(
                //                     labelText: 'Search',
                //                     hintText: 'Start typing to search',
                //                     prefixIcon: const Icon(Icons.search),
                //                     border: OutlineInputBorder(
                //                       borderSide: BorderSide(
                //                         color: const Color(0xFF8C98A8)
                //                             .withOpacity(0.2),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 onSelect: (value) {
                //                   setState(() {
                //                     selectedCountry = value;
                //                   });
                //                 },
                //               );
                //             },
                //             child: Text(
                //               "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                //               textAlign: TextAlign.center,
                //               style: const TextStyle(
                //                 fontSize: 18,
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ),
                //         suffixIcon: phoneController.text.length > 9
                //             ? Container(
                //                 height: 32,
                //                 width: 32,
                //                 decoration: const BoxDecoration(
                //                   shape: BoxShape.circle,
                //                   color: Colors.amber,
                //                 ),
                //                 child: const Icon(
                //                   Icons.done,
                //                   color: Colors.white,
                //                   size: 20,
                //                 ),
                //               )
                //             : null,
                //       ),
                //       keyboardType: TextInputType.phone,
                //     ),
                //   ),
                // ),

                40.heightBox,
                GestureDetector(
                  onTap: () async {
                    if (kDebugMode) {
                      print(phoneController.text + phone);
                    }
                    Get.to(() => const VerificationScreen(
                          phoneNumber: '',
                        ));
                    if (phoneController.text.isNotEmpty) {
                      Fluttertoast.showToast(msg: 'Processing please wait...');
                      // setState(() {
                      //   loading = true;
                      // });

                      try {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: phoneController.text + phone,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {
                            loading = false;
                            // showDialog(
                            //   context: context,
                            //   builder: (context) => AlertDialog(
                            //     title: const Text('Verification Failed'),
                            //     content:
                            //         Text(e.message ?? 'Unknown error occurred.'),
                            //     actions: [
                            //       TextButton(
                            //         onPressed: () => Navigator.pop(context),
                            //         child: const Text('OK'),
                            //       ),
                            //     ],
                            //   ),
                            // );
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            LoginPage.verify = verificationId;
                            Get.to(() => VerificationScreen(
                                  phoneNumber: phoneController.text,
                                ));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      } catch (e) {
                        Get.snackbar('Enter phone number', '');
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter phone number'),
                        ),
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: Get.size.width,
                        decoration: BoxDecoration(
                          color:
                              loading ? loadingButtonColor : defaultButtonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Visibility(
                            visible: !loading,
                            child: const Text(
                              'Login',
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
          ),
        ),
      ),
    );
  }
}
