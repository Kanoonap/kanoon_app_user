import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:
        
        
        
        
         Column(
           children: [
            const SizedBox(
              height: 38,
            ),
             Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
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
                      SizedBox(width: Get.width * .28),
                      const Text(
                        'Help',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 11,
                ),
             const Padding(
               padding: EdgeInsets.symmetric(horizontal: 18,vertical: 6
               ),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    'Title: Kanoon App\nYour Personal Legal Companion\n\nDescription:',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Welcome to Kanoon App, your ultimate solution for all legal needs right at your fingertips. With Kanoon app user-friendly interface and comprehensive features, managing your legal affairs has never been easier',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Key Features :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Find Your Perfect Lawyer :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Browse through a diverse database of experienced lawyers specializing in various fields of law. Whether you need a criminal defense attorney, a family law expert, or a business law consultant, Kanoon App has got you covered.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Book Appointments Instantly :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'No more waiting on hold or playing phone tag. With Kanoon App, booking appointments with your preferred lawyer is just a few taps away. Choose your preferred time slot and schedule appointments hassle-free.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Secure Communication :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Communicate with your lawyer securely through the app encrypted messaging system. Discuss your case details, share documents, and receive legal advice conveniently without compromising on privacy.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Review and Ratings :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Share your experience and rate the services provided by your lawyer. Help fellow users make informed decisions by leaving honest reviews.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '24/7 Support :',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Have questions or need assistance? Our dedicated support team is available round-the-clock to address your concerns and provide timely assistance.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Why Choose kanoon App ?',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Kanoon App simplifies the legal process, putting the power of legal representation in your hands. Whether you are facing a legal challenge or seeking preventive legal advice, Kanoon App ensures that you have access to top-notch legal professionals whenever and wherever you need them.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Download Kanoon App today and experience a revolutionary approach to managing your legal affairs. Empower yourself with knowledge, expertise, and convenience—all within the palm of your hand. Kanoon App: Your Personal Legal Companion.',
                    textAlign: TextAlign.center,
                  ),
                 ],
                         ),
             ),
           ],
         ),
      ),
    );
  }
}
