// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/common_widget/apptheme.dart';

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
    double sizeHeight = TSizeUtils.hPercent(100, context: context);
    double sizeWidth = TSizeUtils.wPercent(100, context: context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
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
                          color: Theme.of(context).colorScheme.primaryFixedDim),
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                    getLoginOtp();
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - 120,
                      height: 40,
                      child: Center(child: Text('Get OTP')))),
              // Button(
              //     text: "Get OTP",
              //     onPressed: () async {
              //       if (mobileNo.length == 13) {
              //         String mobile = ref
              //             .read(mobileNumberProvider.notifier)
              //             .state = mobileNo;
              //         GetOtpReq otpReq = GetOtpReq(phno: mobile, otp: 'string');
              //         final otp = otpReq.toJson();

              //         showDialog(
              //           barrierDismissible: false,
              //           barrierColor: Colors.transparent,
              //           context: context,
              //           builder: (context) {
              //             return Dialog(
              //               backgroundColor: Colors.transparent,
              //               alignment: Alignment.center,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: SizedBox(
              //                 height: MediaQuery.of(context).size.height,
              //                 width: MediaQuery.of(context).size.width,
              //                 child: const Center(
              //                   child: CircularProgressIndicator(),
              //                 ),
              //               ),
              //             );
              //           },
              //         );

              //         try {
              //           final otpResult =
              //               await ref.read(loginUserProvider(otp).future);

              //           Navigator.pop(context);

              //           if (otpResult.status == 'Success') {
              //             if (otpResult.result ==
              //                 'Mobile number is not registered. Please register your account.') {
              //               // ignore: use_build_context_synchronously
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                   const SnackBar(
              //                       content: Text(
              //                           'Your mobile number doesn\'t exist. Please register your profile')));
              //             } else if (otpResult.result ==
              //                 'An error occurred during login. Please try again later.') {
              //               // ignore: use_build_context_synchronously
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                   const SnackBar(content: Text('Error occured')));
              //             } else {
              //               ref.read(otpProvider.notifier).state =
              //                   otpResult.result!;

              //               // ignore: use_build_context_synchronously
              //               Navigator.popAndPushNamed(context, 'VerifyOtp');
              //             }
              //           }
              //         } catch (ex) {
              //           Navigator.pop(context); // Close loading dialog
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             // SnackBar(content: Text('Error: $ex')),
              //             SnackBar(
              //                 content: Text(
              //                     'Your mobile number doesn\'t exist. Please register your profile')),
              //           );
              //           debugPrint('Error: $ex');
              //         }
              //       } else if (mobileNo.isEmpty) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text('Enter your mobile number')),
              //         );
              //       }
              //     }),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Choose Language",
                  //   style: TextStyle(
                  //       color: AppTheme.orangeColor,
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 12),
                  // ),
                  TextButton(
                    child: Text(
                      'Register',
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
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
                        color: Theme.of(context).colorScheme.primaryContainer,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
          if (otpResult.result ==
              'Mobile number is not registered. Please register your account.') {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'Your mobile number doesn\'t exist. Please register your profile')));
          } else if (otpResult.result ==
              'An error occurred during login. Please try again later.') {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Error occured')));
          } else {
            ref.read(otpProvider.notifier).state = otpResult.result!;

            // ignore: use_build_context_synchronously
            Navigator.popAndPushNamed(context, 'VerifyOtp');
          }
        }
      } catch (ex) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          // SnackBar(content: Text('Error: $ex')),
          SnackBar(
              content: Text(
                  'Your mobile number doesn\'t exist. Please register your profile')),
        );
        debugPrint('Error: $ex');
      }
    } else if (mobileNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter your mobile number')),
      );
    }
  }
}
