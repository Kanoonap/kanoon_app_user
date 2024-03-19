import 'package:flutter/material.dart';
import 'package:kanoon_app/dashboard/dashboard.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentBooked extends StatefulWidget {
  const AppointmentBooked({super.key});

  @override
  State<AppointmentBooked> createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.heightBox,
            Row(
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
                const SizedBox(width: 50),
                const Text(
                  'Successfully',
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/tick.png'),
                    const Text(
                      'Thank you for your\n Appoitnment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF101817),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    5.heightBox,
                    const Text(
                      'Appointment also has been placed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    50.heightBox,
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Dashboard()));
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Visibility(
                                  child: Text(
                                    'Back to Home',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // if (loading)
                            //   const Positioned.fill(
                            //     child: Center(
                            //       child: CircularProgressIndicator(
                            //         valueColor: AlwaysStoppedAnimation<Color>(
                            //           Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
