// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_build_context_synchronously, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';
import 'package:temple_app/data/dtos/get_otp_req_dto.dart';
import 'package:temple_app/data/dtos/get_register_model_dto.dart';
import 'package:temple_app/data/dtos/verify_otp_req.dart';
import 'package:temple_app/data/repository/login_repository.dart';
import 'package:temple_app/mobile/presentaion/login/login_screen.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/signUpUser.dart';
import '../../../common_widget/apptheme.dart';
import '../../../common_widget/button.dart';
import '../../../data/repository/get_register_repository.dart';
import '../../../src/core/assets/assets.gen.dart';
import '../../../utils/preference.dart';
import '../../../utils/size_utils.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends ConsumerStatefulWidget {
  const VerifyOTP({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends ConsumerState<VerifyOTP> {
  late TextEditingController otp;
  String? mobileNumber;
  TextEditingController controllerOfOtp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String fetchedOTP = ref.watch(otpProvider);
    otp = TextEditingController(text: fetchedOTP);
    mobileNumber = ref.watch(mobileNumberProvider);
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   toolbarHeight: TSizeUtils.aHPercent(7, context: context),
      //   actions: [],
      //   centerTitle: true,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: const Icon(
      //       size: 25,
      //       Icons.keyboard_arrow_left,
      //       color: Colors.white,
      //     ),
      //   ),
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //         gradient: LinearGradient(
      //       colors: [
      //         AppTheme.primayColor,
      //         Color.fromARGB(255, 65, 102, 133),
      //       ],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //     )),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('OTP Verification',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // color: AppTheme.primayColor,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                          Icons.sms,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Image.asset(
            //   Assets.images.otp.path,
            //   height: sizeHeight * 0.2,
            //   width: sizeWidth,
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('We have sent the Verification code to',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                        // color: AppTheme.primayColor,
                        )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mobileNumber!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    )),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Pinput(
              length: 4,
              // controller: otp,
              controller: controllerOfOtp,
              defaultPinTheme: defaultPinTheme,
              onSubmitted: (value) {
                debugPrint(value);
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  verifyOtpSentFromApi();
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    height: 40,
                    child: Center(child: Text('Verify OTP')))),
            // Button(
            //   text: "Verify OTP",
            //   onPressed: () async {
            //     if (controllerOfOtp.text.isNotEmpty) {
            //       VerifyOtpReq otpReq =
            //           // VerifyOtpReq(otp: fetchedOTP, phno: mobileNumber);
            //           VerifyOtpReq(
            //               otp: controllerOfOtp.text, phno: mobileNumber);
            //       final otp = otpReq.toJson();
            //       showCustomDialog();
            //       try {
            //         final result =
            //             await ref.read(verifyOtpProvider(otp).future);
            //         Navigator.pop(context);
            //         if (result.status == 'Success') {
            //           if (result.verifyOtpResult!.message ==
            //               'Login successful!') {
            //             await Preference.shared.setString(Preference.USER_ID,
            //                 result.verifyOtpResult!.userId.toString());
            //             final userID =
            //                 Preference.shared.getString(Preference.USER_ID);
            //             ref
            //                 .read(userIdProvider.notifier)
            //                 .update((state) => userID);
            //             final userdetails =
            //                 await GetRegisterRepository().getRegister(userID!);
            //             //************************ */
            //             await Preference.shared.setString(Preference.USER_NAME,
            //                 userdetails.result!.name.toString());
            //             //************************* */
            //             //trial code for storing data offline/local storage
            //             var profileBox =
            //                 Hive.box<UserProfile>('userProfileBox');
            //             var userProfile = UserProfile(
            //                 name: userdetails.result!.name,
            //                 sex: userdetails.result!.sex,
            //                 address: userdetails.result!.address,
            //                 dob: userdetails.result!.dob,
            //                 email: userdetails.result!.email,
            //                 fatherPhNo: userdetails.result!.fatherPhNo,
            //                 maritalStatus: userdetails.result!.maritalStatus,
            //                 phno: userdetails.result!.phno,
            //                 spousePhNo: userdetails.result!.spousePhNo);
            //             await profileBox.add(userProfile);
            //             //trial code for storing data offline/local storage
            //             Navigator.popAndPushNamed(context, 'HomeScreen');
            //           } else {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(content: Text('Something went wrong')),
            //             );
            //           }
            //         }
            //       } catch (ex) {
            //         Navigator.pop(context); // Close loading dialog
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(content: Text('Error: $ex')),
            //         );
            //         debugPrint('Error: $ex');
            //       }
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //           content: Text('Enter your OTP which has been sent')));
            //     }
            //   },
            // ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Didn\'t receive OTP?   ',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.blackColor,
                    )),
                TextButton(
                  child: Text('Resend',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).colorScheme.primaryContainer)),
                  onPressed: () async {
                    showCustomDialog();
                    try {
                      GetOtpReq otpReq =
                          GetOtpReq(phno: mobileNumber, otp: 'string');
                      final otp = otpReq.toJson();

                      final otpResult =
                          await ref.read(loginUserProvider(otp).future);

                      Navigator.pop(context);

                      if (otpResult.status == 'Success') {
                        if (otpResult.result ==
                            'Mobile number is not registered. Please register your account') {
                        } else if (otpResult.result ==
                            'An error occurred during login. Please try again later') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'An error occurred during login. Please try again later')));
                        } else {
                          ref.read(otpProvider.notifier).state =
                              otpResult.result!;
                        }
                      }
                    } catch (ex) {
                      Navigator.pop(context); // Close loading dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $ex')),
                      );
                      debugPrint('Error: $ex');
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  verifyOtpSentFromApi() async {
    if (controllerOfOtp.text.isNotEmpty) {
      VerifyOtpReq otpReq =
          // VerifyOtpReq(otp: fetchedOTP, phno: mobileNumber);
          VerifyOtpReq(otp: controllerOfOtp.text, phno: mobileNumber);
      final otp = otpReq.toJson();
      showCustomDialog();
      try {
        final result = await ref.read(verifyOtpProvider(otp).future);
        Navigator.pop(context);
        if (result.status == 'Success') {
          if (result.verifyOtpResult!.message == 'Login successful!') {
            await Preference.shared.setString(
                Preference.USER_ID, result.verifyOtpResult!.userId.toString());
            final userID = Preference.shared.getString(Preference.USER_ID);
            ref.read(userIdProvider.notifier).update((state) => userID);
            final userdetails =
                await GetRegisterRepository().getRegister(userID!);
            //************************ */
            await Preference.shared.setString(
                Preference.USER_NAME, userdetails.result!.name.toString());
            //************************* */
            //trial code for storing data offline/local storage
            var profileBox = Hive.box<UserProfile>('userProfileBox');
            var userProfile = UserProfile(
                name: userdetails.result!.name,
                sex: userdetails.result!.sex,
                address: userdetails.result!.address,
                dob: userdetails.result!.dob,
                email: userdetails.result!.email,
                fatherPhNo: userdetails.result!.fatherPhNo,
                maritalStatus: userdetails.result!.maritalStatus,
                phno: userdetails.result!.phno,
                spousePhNo: userdetails.result!.spousePhNo);
            await profileBox.add(userProfile);
            //trial code for storing data offline/local storage
            Navigator.popAndPushNamed(context, 'HomeScreen');
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter your OTP which has been sent')));
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
