import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/authentication/data_screen.dart';
import 'package:pinput/pinput.dart';
import 'login_page.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const VerificationScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TimerManager timerManager = TimerManager();

  bool loading = false;
  bool isVerifying = false;
  int _timerValue = 60;
  String code = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 140),
              const Text(
                'Confirm OTP',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter the OTP we sent to ${widget.phoneNumber}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (_timerValue == 0) {
                    timerManager.startTimer(() {});
                    setState(() {
                      _timerValue = 60;
                    });
                  }
                },
                child: Text(
                  _timerValue == 0
                      ? 'Resend OTP'
                      : 'Resend OTP in $_timerValue seconds',
                  style: TextStyle(
                    fontSize: 18,
                    color: _timerValue == 0 ? Colors.amber : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Pinput(
                length: 6,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () async {
                  // Get.to(()=>const DataScreen());
                  showModals();

                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: LoginPage.verify, smsCode: code);

                    await auth.signInWithCredential(credential);
                    Get.to(() => const DataScreen());
                    Get.snackbar('Success', '');
                  } catch (e) {
                    Get.snackbar('Success', '');
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 349 * 12,
                      decoration: BoxDecoration(
                        color: loading ? Colors.grey : Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Visibility(
                          visible: !loading,
                          child: const Text(
                            'Confirm Code',
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
    );
  }

  void showModals() {
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
                  'assets/ticking.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  ' Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Redirecting to the home page in a few seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF888B92),
                    fontSize: 16,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
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
          context, MaterialPageRoute(builder: (_) => const DataScreen()));
      // Navigator.of(context).pop();
    });
  }

  void _startResendTimer() {
    timerManager.startTimer(() {
      if (_timerValue == 0) {
        timerManager.cancelTimer();
        setState(() {
          _timerValue = 60;
        });
      } else {
        setState(() {
          _timerValue--;
        });
      }
    });
  }
}

class TimerManager {
  late Timer _resendTimer;
  bool _timerActive = false;
  int _timerDuration = 60;

  bool get isTimerActive => _timerActive;
  int get timerDuration => _timerDuration;

  void startTimer(Function() callback) {
    _timerActive = true;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDuration == 0) {
        _timerActive = false;
        _timerDuration = 60;
        _resendTimer.cancel();
      } else {
        _timerDuration--;
        callback();
      }
    });
  }

  void cancelTimer() {
    _timerActive = false;
    _timerDuration = 60;
    _resendTimer.cancel();
  }
}
