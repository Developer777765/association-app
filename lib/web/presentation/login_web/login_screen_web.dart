// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, annotate_overrides, unused_element, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:temple_app/common_widget/apptheme.dart';
import 'package:temple_app/common_widget/responsive_widget.dart';
import 'package:temple_app/mobile/presentaion/login/verify_otp.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/signUpUser.dart';
import 'package:temple_app/mobile/presentaion/splash/splash_screen.dart';
import 'package:temple_app/src/core/assets/assets.gen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../common_widget/button.dart';
import '../../../../data/dtos/get_otp_req_dto.dart';
import '../../../../data/repository/login_repository.dart';
import '../../../../utils/size_utils.dart';
import '../../../core/utils/CustomTextField.dart';
import '../../../data/dtos/verify_otp_req.dart';
import '../../../data/repository/get_register_repository.dart';
import '../../../utils/loader.dart';
import '../../../utils/preference.dart';
import '../../router_web/route_enums_web.dart';
import '../dashboard_web/dashoard_web_menu.dart';
import '../signup_web/signup_web.dart';

final mobileNumberProvider = StateProvider<String>((ref) {
  return '';
});
final otpProvider = StateProvider<String>((ref) {
  return '';
});

class LoginScreenWeb extends ConsumerStatefulWidget {
  const LoginScreenWeb({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreenWeb> {
  String mobileNo = '';

  @override
  void initState() {
    super.initState();
  }

  bool get isWeb => identical(0, 0.0);

  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final FocusNode textFieldFocusNode = FocusNode();

    // String fetchedOTP = ref.watch(otpProvider);

    // otpController = TextEditingController(text: fetchedOTP);

    // debugPrint('OTPFETCH:$fetchedOTP');

    double sizeHeight = TSizeUtils.hPercent(100, context: context);
    double sizeWidth = TSizeUtils.wPercent(100, context: context);
    final _formKey = GlobalKey<FormState>();
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(fontSize: 10, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey,
        ), // Set border color
      ),
    );

    verifyOTPCall() async {
      if (otpController.text.isEmpty || otpController.text.length != 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid 4-digit OTP')),
        );
        return;
      }
      VerifyOtpReq otpReq = VerifyOtpReq(
          otp: otpController.text, phno: '+91${mobileController.text}');
      final otp = otpReq.toJson();
      TUtility().loader(context);
      try {
        final result = await ref.read(verifyOtpProvider(otp).future);
        Navigator.pop(context);
        if (result.status == 'Success') {
          if (result.verifyOtpResult!.message == 'Login successful!') {
            await Preference.shared.setString(
                Preference.USER_ID, result.verifyOtpResult!.userId.toString());
            final userID = Preference.shared.getString(Preference.USER_ID);
            ref.read(userIdProvider.notifier).update((state) => userID);
            final userdetails = await GetRegisterRepository()
                .getRegister(userID!, ref.read(companyId));
            await Preference.shared.setString(
                Preference.USER_NAME, userdetails.result!.name.toString());
            ref.read(profileProvider.notifier).state =
                Profile(userName: userdetails.result!.name);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashoardWebMenu()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Something went wrong')),
            );
          }
        }
      } catch (ex) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $ex')),
        );
        debugPrint('Error: $ex');
      }
    }

    void _showDialog(BuildContext context) {
      MediaQuery.of(context).size.width < 700
          ? showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text("OTP Verification",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primayColor,
                        )),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.images.otp.path,
                        height: sizeHeight * 0.09,
                        width: sizeWidth * 0.2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('We have send the Verification code to',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primayColor,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('+91${mobileController.text}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.brownishRedColor,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Pinput(
                            length: 4,
                            controller: otpController,
                            defaultPinTheme: defaultPinTheme,
                            onSubmitted: (value) {
                              debugPrint(value);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primayColor,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () async {
                        // mobile
                        verifyOTPCall();
                      },
                      child: const Text("Verify",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.whiteColor,
                          )),
                    ),
                  ],
                );
              },
            )
          : showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    Container(
                      width: sizeHeight,
                      height: sizeHeight * 0.65,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: AppTheme.primayColor,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('OTP Verification',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primayColor,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              Assets.images.otp.path,
                              height: sizeHeight * 0.2,
                              width: sizeWidth,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('We have send the Verification code to',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.primayColor,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('+91${mobileController.text}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.brownishRedColor,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Pinput(
                              length: 4,
                              controller: otpController,
                              defaultPinTheme: defaultPinTheme,
                              onSubmitted: (value) {
                                debugPrint(value);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 60,
                              width: sizeWidth * 0.2,
                              child: Button(
                                //web and tablet
                                text: "Verify",
                                onPressed: () async {
                                  verifyOTPCall();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
    }

    getOTP() async {
      if (mobileController.text.isNotEmpty) {
        final String mobileNumber = mobileController.text;

        GetOtpReq otpReq = GetOtpReq(phno: '+91${mobileNumber}', otp: 'string');
        final otp = otpReq.toJson();
        TUtility().loader(context);
        try {
          final otpResult = await ref.read(loginUserProvider(otp).future);

          Navigator.pop(context);

          if (otpResult.status == 'Success') {
            if (otpResult.result ==
                'Mobile number is not registered. Please register your account.') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Your mobile number doesn\'t exist. Please register profile')));
            } else if (otpResult.result ==
                'An error occurred during login. Please try again later.') {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Error occured')));
            } else {
              // ref.read(otpProvider.notifier).state =
              //     otpResult.result!;
              print('123: ${otpResult.result}');
              _showDialog(context);
            }
          }
        } catch (ex) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Mobile number is not registered. Please register your account.')),
          );
          debugPrint('Error: $ex');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Enter Your Mobile Number ')));
      }
    }

    return Scaffold(
      body: Form(
        key: MediaQuery.of(context).size.width < 700 ? null : _formKey,
        child: ResponsiveWidget(
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.login.path,
                    height: sizeHeight * 0.5,
                    width: sizeWidth * 0.15,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Welcome Back! ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primayColor,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Login and Start your amazing journey',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.blackColor,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: sizeHeight * 0.09,
                    width: sizeWidth * 0.25,
                    child: CommomTextFormField(
                      controller: mobileController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Mobile Number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone No is required";
                        } else if (value.length != 10) {
                          return "Invalid Phone No";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: sizeHeight * 0.1,
                    width: sizeWidth * 0.24,
                    child: Button(
                        text: "Get OTP", //web
                        onPressed: () async {
                          getOTP();
                        }),
                  ),
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
                          'Register', //web
                          style: TextStyle(
                              color: Color(0xFF0D256E),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          context.goNamed(Routes.signupWeb.name);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: sizeWidth * 0.1,
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
                                  fontWeight: FontWeight.bold),
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
                          width: sizeWidth * 0.1,
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
                                  fontWeight: FontWeight.bold),
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkRedColor,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          mobile: SingleChildScrollView(
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
                          color: AppTheme.primayColor,
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
                          color: AppTheme.blackColor,
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Image.asset(
                  Assets.images.login.path,
                  height: sizeHeight * 0.2,
                  width: sizeWidth,
                ),
                SizedBox(height: 30),
                Container(
                  height: sizeHeight * 0.07,
                  width: sizeWidth * 0.89,
                  child: CommomTextFormField(
                    controller: mobileController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Mobile Number',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                    height: sizeHeight * 0.08,
                    width: sizeWidth * 0.87,
                    child: Button(
                        text: "Get OTP", //mobile
                        onPressed: () async {
                          getOTP();
                        })),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'Register', //mobile
                        style: TextStyle(color: Color(0xFF0D256E)),
                      ),
                      onPressed: () {
                        context.goNamed(Routes.signupWeb.name);
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
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkRedColor,
                        )),
                  ],
                ),
              ],
            ),
          ),
          tablet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.login.path,
                    height: sizeHeight * 0.5,
                    width: sizeWidth * 0.15,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('Welcome Back! tab ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primayColor,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login and Start your amazing journey',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.blackColor,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: sizeHeight * 0.1,
                    width: sizeWidth * 0.3,
                    child: CommomTextFormField(
                      controller: mobileController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Mobile Number',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone No is required";
                        } else if (value.length != 10) {
                          return "Invalid Phone No";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: sizeHeight * 0.1,
                    width: sizeWidth * 0.3,
                    child: Button(
                        text: "Get OTP", //tablet
                        onPressed: () async {
                          getOTP();
                        }),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          'Register', //tablet
                          style: TextStyle(
                              color: Color(0xFF0D256E),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          context.goNamed(Routes.signupWeb.name);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: sizeWidth * 0.1,
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
                                  fontWeight: FontWeight.bold),
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
                          width: sizeWidth * 0.1,
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
                                  fontWeight: FontWeight.bold),
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkRedColor,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
