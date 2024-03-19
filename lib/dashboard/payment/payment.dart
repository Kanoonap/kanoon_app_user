// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanoon_app/dashboard/payment/appointment_book.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cvvController = TextEditingController();
  String selectedMonth = 'January';
  String selectedYear = '2023';

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> years = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030'
  ];
  @override
  void dispose() {
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          child: Column(
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
                   SizedBox(width: Get.width*.23),
                  const Center(
                    child: Text(
                      'Payment',
                      style:  TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 341,
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Abdul Wahab',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Image.asset(
                              'assets/master.png',
                              height: 24,
                              width: 38,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Icon(
                            //   Icons.credit_card,
                            //   color: Colors.white,
                            // ),
                            Text(
                              '4562 1122 4595 1234',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        20.heightBox,
                        Row(
                          children: [
                            // Icon(
                            //   Icons.credit_card,
                            //   color: Colors.white,
                            // ),
                            const Text(
                              'Exp Date',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                            30.widthBox,
                            const Text(
                              'CVC Number',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        5.heightBox,
                        Row(
                          children: [
                            // Icon(
                            //   Icons.credit_card,
                            //   color: Colors.white,
                            // ),
                            const Text(
                              '23/16',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            65.widthBox,
                            const Text(
                              '962',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Payment Methods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 44,
                    width: 62.98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Image.asset(
                      'assets/master.png',
                      height: 44,
                      width: 62.98,
                    ),
                  ),
                  50.widthBox,
                  Container(
                    height: 44,
                    width: 62.98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Image.asset(
                      'assets/jazz.png',
                      height: 44,
                      width: 62.98,
                    ),
                  ),
                  50.widthBox,
                  Container(
                    height: 44,
                    width: 62.98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Image.asset(
                      'assets/easy.png',
                      height: 44,
                      width: 62.98,
                    ),
                  ),
                ],
              ),
              10.heightBox,
              const Text(
                'Card Number',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                // controller: nameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black, // Change border color
                    ),
                  ),
                  hintText: "*********",
                  focusColor: Colors.green,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
              ),
              10.heightBox,
              const Text(
                'Card Holder Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                // controller: nameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black, // Change border color
                    ),
                  ),
                  hintText: "Abdul Wahab",
                  focusColor: Colors.green,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Card holder name';
                  }
                  return null;
                },
              ),
              10.heightBox,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CVC',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Month',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      'Year',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    height: 65,
                    child: TextFormField(
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        hintText: 'Enter CVV',
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 3,
                      onChanged: (value) {
                        // Handle CVV changes
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVV';
                        }
                        // Add other validation conditions if needed
                        return null;
                      },
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedMonth,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                    items: months.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedYear,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                    items: years.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              20.heightBox,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Zain Asif',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Rs.100000",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              30.heightBox,
              Center(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AppointmentBooked()));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 49,
                        width: 312,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Visibility(
                            child: Text(
                              'Pay Now',
                              style: TextStyle(
                                fontSize: 16,
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
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const PaymentMethodTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          // Action on tapping each payment method
        },
      ),
    );
  }
}

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   @override
//   bool isPaying = false;

//   Future<void> payWithCard({required double amount}) async {
//     setState(() {
//       isPaying = true;
//     });

//     try {
//       // Create Payment Intent on your server
//       final paymentIntentData = await createPaymentIntent(amount, 'USD');
//       // Confirm Payment Intent
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: paymentIntentData['sk_test_51Oreru057vMPxoNyRjoFMFPPDB9nFAo2KFGkOqzi6fbHyBD4tMJZuhSUjI4wYpSvTZm10yhjXkXom0kSOqUbUg7k00pgllhDQC'],
//         merchantDisplayName: 'Your Company Name',
//       ));
//       await Stripe.instance.presentPaymentSheet();

//       setState(() {
//         isPaying = false;
//       });
//       // Handle payment success
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment successful")));
//     } catch (e) {
//       setState(() {
//         isPaying = false;
//       });
//       // Handle payment failure
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed: $e")));
//     }
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency) async {
//     final url = Uri.parse('https://your-server.com/create-payment-intent');
//     final response = await http.post(url, body: {
//       'amount': amount.toString(),
//       'currency': currency,
//     });
//     return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//       ),
//       body: Center(
//         child: isPaying
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//                 child: const Text('Pay'),
//                 onPressed: () => payWithCard(amount: 10.0), // Example amount
//               ),));
//   }
// }