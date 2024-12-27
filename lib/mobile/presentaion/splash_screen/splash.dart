// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../login/login_screen.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});
  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    iniMethod();
  }

  Future<void> iniMethod() async {
    await Future.delayed(Duration(seconds: 4), () async {});
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        // Color(0xFF8EC5FC), // Soft Sky Blue
        Theme.of(context).colorScheme.primaryContainer,
        Theme.of(context).colorScheme.secondaryContainer,

        // Color(0xFFFFD180), // Light Orange
        // Color(0xFFFF8A65), // Coral
        // Color(0xFF6A1B9A), //
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
                      color: Colors.white),
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
          const Spacer(),
        ],
      ),
    ));
  }
}
