// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/common_widget/responsive_widget.dart';
import 'package:temple_app/mobile/presentaion/login/login_screen.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/signUpUser.dart';
import '../../../common_widget/apptheme.dart';
import '../../../common_widget/button.dart';
import '../../../data/repository/get_register_repository.dart';
import '../../../src/core/assets/assets.gen.dart';
import '../../../utils/preference.dart';
import '../../../utils/size_utils.dart';
import 'package:pinput/pinput.dart';

class VerifyOTPWeb extends ConsumerStatefulWidget {
  const VerifyOTPWeb({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends ConsumerState<VerifyOTPWeb> {
  TextEditingController otp = TextEditingController(text: '4856');


  
  @override
  Widget build(BuildContext context) {


    String mobileNumber = ref.watch(mobileNumberProvider);
    double sizeHeight = TSizeUtils.hPercent(100, context: context);
    double sizeWidth = TSizeUtils.wPercent(100, context: context);

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(fontSize: 10, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.white, // Set the fill color
        borderRadius: BorderRadius.circular(25), // Set circular radius
        border: Border.all(
          color: Colors.grey,
        ), // Set border color
      ),
    );
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: TSizeUtils.aHPercent(7, context: context),
        actions: [],
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            size: 25,
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              AppTheme.primayColor,
              Color.fromARGB(255, 65, 102, 133),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
      ),
      body: ResponsiveWidget(
          desktop: Column(
        children: [
        ],
      )),
    );
  }
}
