// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/common_widget/apptheme.dart';
import 'package:temple_app/data/dtos/profile_approval_req_dto.dart';
import 'package:temple_app/mobile/presentaion/home_redefined/testScreen.dart';
import 'package:temple_app/services/customPainter.dart';

import 'package:temple_app/src/core/assets/assets.gen.dart';
import '../../../common_widget/button.dart';
import '../../../data/dtos/get_otp_req_dto.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../data/repository/login_repository.dart';
import '../../../utils/size_utils.dart';
import '../signUpUser/signUpUser.dart';

final mobileNumberProvider = StateProvider<String>((ref) {
  return '';
});

final otpProvider = StateProvider<String>((ref) {
  return '';
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String mobileNo = '';
  @override
  void initState() {
    super.initState();
    // Preference.shared.setString(Preference.USER_ID, (null).toString());
  }

  Widget build(BuildContext context) {
    double sizeWidth = TSizeUtils.wPercent(100, context: context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          //TODO: change the splash screen UI
          // decoration: BoxDecoration(
          //     // color: Theme.of(context).colorScheme.onSecondaryContainer
          //     // color: Theme.of(context).colorScheme.primaryContainer

          //     gradient: LinearGradient(colors: [
          //   // Theme.of(context).colorScheme.primaryContainer,
          //   Theme.of(context).colorScheme.primaryFixedDim,
          //   Theme.of(context).colorScheme.primaryContainer,
          //   // Theme.of(context).colorScheme.secondaryContainer,
          // ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          //////###############///////////////////
          ///

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: CustomPainterOf(),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 5,
                  top: MediaQuery.of(context).size.height / 5,
                  child: CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: CustomPainterOf(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Welcome Back! ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: AppTheme.primayColor,
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login and Start your amazing journey',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              // color: AppTheme.blackColor,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.21,
                      width: MediaQuery.of(context).size.height * 0.21,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryFixedDim),
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              height: MediaQuery.of(context).size.height * 0.14,
                              width: MediaQuery.of(context).size.height * 0.14,
                              child: Center(
                                child: Icon(
                                  Icons.mobile_screen_share,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image.asset(
                    //   Assets.images.login.path,
                    //   height: sizeHeight * 0.2,
                    //   width: sizeWidth,
                    // ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 70,
                        child: IntlPhoneField(
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 20),
                            labelText: 'Mobile',
                            hintText: 'Mobile',
                            hintStyle: TextStyle(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: BorderSide(color: Colors.grey)
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: BorderSide(color: Colors.grey)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            mobileNo = phone.completeNumber;
                          },
                          onSubmitted: (phone) {
                            mobileNo = '+91$phone';
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          // approveRegisteredProfile(65);
                          getLoginOtp();
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return TestScreen(nameOfScreen: 'nameOfScreen');
                          // }));
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 120,
                            height: 40,
                            child: Center(child: Text('Get OTP')))),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            'Register',
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp(isItSignUp: true,)));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: sizeWidth * 0.25,
                            height: 40,
                            decoration: BoxDecoration(
                              // color: controller.tamilOnclick.value
                              //     ? AppTheme.primaryColor
                              //     : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                            child: Center(
                              child: Text(
                                "Tamil",
                                style: TextStyle(
                                  // color: controller.tamilOnclick.value
                                  //     ? Colors.black
                                  //     : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: sizeWidth * 0.25,
                            height: 40,
                            decoration: BoxDecoration(
                              // color: controller.tamilOnclick.value
                              //     ? AppTheme.primaryColor
                              //     : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                            child: Center(
                              child: Text(
                                "English",
                                style: TextStyle(
                                  // color: controller.tamilOnclick.value
                                  //     ? Colors.black
                                  //     : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Version:0.01',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  approveRegisteredProfile(id) async {
    final num = ApproveProfile(id: id).toJson();
    try {
      showCustomDialog();
      final result = await ref.read(profileApprovalProvider(num).future);
      Navigator.pop(context);
      if (result.status == 'Success') {
        getLoginOtp();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Your profile isn\'t approved yet')));
      }
    } catch (ex) {
      rethrow;
    }
  }

  getLoginOtp() async {
    if (mobileNo.length == 13) {
      String mobile = ref.read(mobileNumberProvider.notifier).state = mobileNo;
      GetOtpReq otpReq = GetOtpReq(phno: mobile, otp: 'string');
      final otp = otpReq.toJson();

      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );

      try {
        final otpResult = await ref.read(loginUserProvider(otp).future);

        Navigator.pop(context);

        if (otpResult.status == 'Success') {
          ref.read(otpProvider.notifier).state = otpResult.result!;

          // ignore: use_build_context_synchronously
          Navigator.popAndPushNamed(context, 'VerifyOtp');
        } else if (otpResult.status == 'Failed') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Mobile number doesn\'t exist. Register your account and try again.')),
          );
        }
      } catch (ex) {
        Navigator.pop(context); // Close loading dialog
        // ScaffoldMessenger.of(context).showSnackBar(
        //   // SnackBar(content: Text('Error: $ex')),
        //   SnackBar(content: Text('Try again')),
        //   // SnackBar(
        //   //     content: Text(
        //   //         'Your mobile number doesn\'t exist. Please register your profile')),
        // );
        debugPrint('Error: $ex');
      }
    } else if (mobileNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter your mobile number')),
      );
    }
  }

  showCustomDialog() {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
