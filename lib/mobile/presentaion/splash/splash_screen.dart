// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, await_only_futures, unnecessary_brace_in_string_interps, unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple_app/mobile/presentaion/dashboard/dashboard_screen.dart';
import 'package:temple_app/mobile/presentaion/dashboard/tabbar_widget.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/signUpUser.dart';
import '../../../data/repository/get_register_repository.dart';
import '../../../utils/preference.dart';
import '../login/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    iniMethod();
  }

  Future<void> iniMethod() async {
    await Future.delayed(Duration(seconds: 4), () async {
      final userID = await Preference.shared.getString(Preference.USER_ID);
      print("preffff: $userID");

      if (userID == null) {
        Navigator.popAndPushNamed(context, 'LogIn');
        // Navigator.popAndPushNamed(context, 'BulkUpload');
      } else {
        //original code below(1 line only)
        Navigator.popAndPushNamed(context, 'HomeScreen');
        // Navigator.popAndPushNamed(context, 'BulkUpload');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Theme.of(context).colorScheme.primaryContainer,
        Theme.of(context).colorScheme.secondaryContainer,
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  'Festival of Togetherness, Celebration of Life!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  // width: 100,
                  child: Lottie.asset('assets/animations/sun.json')),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/worshipping2.PNG',
                height: 250,
                width: 250,
              ),
              const Spacer()
            ],
          ),
          Spacer(),
        ],
      ),
    ));
  }
}

// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   ConsumerState<SplashScreen> createState() => _SplashPageState();
// }

// class _SplashPageState extends ConsumerState<SplashScreen> {

//   @override
//   void initState() {
//     super.initState();
//     iniMethod();
//   }

//   Future<void> iniMethod() async {
//     await Future.delayed(Duration(seconds: 4), () async {});
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DashboardScreen(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppTheme.primayColor,
//               Color.fromARGB(255, 65, 102, 133),
//             ],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//           ),
//         ),
//         child: Center(
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.5,
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: Image.asset(
//               "assets/images/applogo.png",
//               errorBuilder: (context, error, stackTrace) =>
//                   const Icon(Icons.error, size: 50, color: Colors.white),
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class Home extends ConsumerStatefulWidget {
// //   const Home({super.key});

// //   @override
// //   ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
// // }

// // class _HomeState extends ConsumerState<Home> {
// //   String? activeLanguage = "";
// //   bool isTamilDisabled = false;
// //   bool isEnglishDisabled = false;

// //   @override
// //   Widget build(BuildContext context) {

// //     final localeNotifier = ref.read(localeProvider.notifier);
// //     final sizeWidth = MediaQuery.of(context).size.width;

// //     return Scaffold(
// //       appBar: AppBar(title: Text(tr('homePageTitle'))),
// //       body: Column(
// //         children: [
// //           Center(
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 GestureDetector(
// //                   onTap: isEnglishDisabled
// //                       ? null
// //                       : () {
// //                           setState(() {
// //                             if (activeLanguage == "English") {
// //                               isEnglishDisabled = true;
// //                             } else {
// //                               activeLanguage = "English";
// //                               isEnglishDisabled = false;
// //                               isTamilDisabled = false;
// //                               localeNotifier.state = Locale('en', 'US');
//                               context.setLocale(Locale('en', 'US'));
//                             }
//                           });
//                         },
//                   child: Container(
//                     width: sizeWidth * 0.25,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: activeLanguage == "English"
//                           ? Colors.green
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: activeLanguage == "English"
//                             ? Colors.green
//                             : Colors.grey,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "English",
//                         style: TextStyle(
//                           color: activeLanguage == "English"
//                               ? Colors.white
//                               : Colors.black,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 32),
//                 GestureDetector(
//                   onTap: isTamilDisabled
//                       ? null
//                       : () {
//                           setState(() {
//                             if (activeLanguage == "Tamil") {
//                               isTamilDisabled = true;
//                             } else {
//                               activeLanguage = "Tamil";
//                               isTamilDisabled = false;
//                               isEnglishDisabled = false;
//                               localeNotifier.state = Locale('ta', 'IN');
//                               context.setLocale(Locale('ta', 'IN'));
//                             }
//                           });
//                         },
//                   child: Container(
//                     width: sizeWidth * 0.25,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: activeLanguage == "Tamil"
//                           ? Colors.green
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: activeLanguage == "Tamil"
//                             ? Colors.green
//                             : Colors.grey,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Tamil",
//                         style: TextStyle(
//                           color: activeLanguage == "Tamil"
//                               ? Colors.white
//                               : Colors.black,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 32),
//           Text(
//             tr('helloMessage'),
//             style: const TextStyle(fontSize: 24),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (activeLanguage == null || activeLanguage!.isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content:
//                         Text('Please select a language before proceeding.'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//               } else {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               }
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
