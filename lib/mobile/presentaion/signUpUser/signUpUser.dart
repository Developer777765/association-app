import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temple_app/core/utils/CustomTextField.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:temple_app/services/networkStatus.dart';
import '../../../data/dtos/userInfoReq.dart';
import '../../../data/repository/login_repository.dart';

final maritalStatusProvider = StateProvider<bool>((ref) => false);
final phoneErrorMsgProvider = StateProvider<String>((ref) => '');
final profileProvider = StateProvider<Profile>((ref) {
  return Profile();
});

class Profile {
  String? userName;
  String? mobileNo;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? address;
  String? id;
  Profile(
      {this.userName,
      this.mobileNo,
      this.gender,
      this.dateOfBirth,
      this.email,
      this.id,
      this.address});
}

class SignUp extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignUp> createState() {
    return SignUpState();
  }
}

class SignUpState extends ConsumerState<SignUp> {
  final formKey = GlobalKey<FormState>();
  String? parentsPhoneNo;
  String? wifePhoneNo;
  String errorMessage = '';
  bool arePhoneNumbersUnique = true;
  bool arePhoneNumbersUnique2 = true;
  List<String> userMaritalStatus = ['Unmarried', 'Married'];
  String gender = 'M';
  String month = 'January';
  int day = 01;
  List<String> genders = ['Male', 'Female', 'Other'];
  File? profilePic;
  bool hasNetworkChanged = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var checkNetworkStatus = ref.watch(networkStatusProvider);
    bool isUserMarried = ref.watch(maritalStatusProvider);
    if (checkNetworkStatus == ConnectivityStatus.isConnected) {
      hasNetworkChanged = true;
      debugPrint('network changes ');
    } else if (checkNetworkStatus == ConnectivityStatus.isDisconnected &&
        hasNetworkChanged) {
      hasNetworkChanged = false;
      Future(() {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'You are offline!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
      });
    } else {
      debugPrint('this is someting else');
    }
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    'Let\'s register your profile!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  const Text(
                    'Enter Your Personal Data to Create One',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await pickImage();
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          child: profilePic == null
                              ? const Icon(
                                  Icons.person_sharp,
                                  size: 50,
                                )
                              : ClipOval(
                                  child: Image.file(
                                    width: 140,
                                    height: 140,
                                    File(profilePic!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        const Positioned(
                            top: 105,
                            right: 8,
                            child: Icon(
                              Icons.camera_alt,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    label: 'Name',
                    isFieldNotEditable: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Are you married?',
                              style: TextStyle(fontSize: 15),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Text('Yes'),
                                Radio<bool>(
                                  groupValue: isUserMarried,
                                  value: true,
                                  onChanged: (val) {
                                    ref
                                        .read(maritalStatusProvider.notifier)
                                        .state = true;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                const Text('No'),
                                Radio<bool>(
                                  groupValue: isUserMarried,
                                  value: false,
                                  onChanged: (val) {
                                    ref
                                        .read(maritalStatusProvider.notifier)
                                        .state = false;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 30),
                  CustomTextField(
                    label: 'Phone No',
                    hint: 'Enter your phone number',
                    isFieldNotEditable: false,
                    keyBoardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    label: 'Parent\'s Phone No(Optional)',
                    hint: 'Enter Father\'s (or) Mother\'s phone number',
                    isFieldNotEditable: false,
                    keyBoardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 30),
                  isUserMarried
                      ? CustomTextField(
                          label: 'Wife\'s Phone No(Optional)',
                          hint: 'Enter Wife\'s phone number',
                          isFieldNotEditable: false,
                          keyBoardType: TextInputType.phone,
                        )
                      : const SizedBox(height: 0),
                  SizedBox(
                    height: isUserMarried ? 30 : 1,
                  ),
                  CustomTextField(
                    label: 'Date of Birth',
                    hint: 'DD-MM-YYYY',
                    isFieldNotEditable: true,
                    controller: TextEditingController(),
                    initialText: 'DD-MM-YYYY',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomDropdown(
                          decoration: const CustomDropdownDecoration(
                              closedFillColor: Colors.transparent,
                              headerStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                          hintText: 'Select gender',
                          items: genders,
                          initialItem: genders[0],
                          onChanged: (val) {
                            switch (val) {
                              case 'Male':
                                gender = 'M';
                                break;
                              case 'Female':
                                gender = 'F';
                                break;
                              case 'Other':
                                gender = 'O';
                              default:
                                gender = 'M';
                            }
                            // gender = val!;
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    label: 'Address',
                    isFieldNotEditable: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    label: 'Email',
                    isFieldNotEditable: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () async {
                        // print('the phone no is $phoneNo');
                        if (formKey.currentState!.validate()) {
                          Map<dynamic, dynamic> userInfo =
                              ref.read(userDataProvider.notifier).state;
                          print('we are inside of lib/mobile/presentation');
                          //
                          //phone number uniqueness validation
                          if (userInfo['Parent\'s Phone No(Optional)'] !=
                                  null &&
                              userInfo['Parent\'s Phone No(Optional)']
                                  .toString()
                                  .isNotEmpty) {
                            if (userInfo['Phone No'] ==
                                    userInfo['Parent\'s Phone No(Optional)'] ||
                                userInfo['Parent\'s Phone No(Optional)'] ==
                                    userInfo['Wife\'s Phone No(Optional)']) {
                              arePhoneNumbersUnique = false;
                            } else {
                              arePhoneNumbersUnique = true;
                            }
                          }
                          if (userInfo['Wife\'s Phone No(Optional)'] != null &&
                              userInfo['Wife\'s Phone No(Optional)']
                                  .toString()
                                  .isNotEmpty) {
                            if (userInfo['Phone No'] ==
                                    userInfo['Wife\'s Phone No(Optional)'] ||
                                userInfo['Parent\'s Phone No(Optional)'] ==
                                    userInfo['Wife\'s Phone No(Optional)']) {
                              arePhoneNumbersUnique2 = false;
                            } else {
                              arePhoneNumbersUnique2 = true;
                            }
                          }
                          //phone number uniqueness validation
                          UserInfoReq user = UserInfoReq(
                              name: userInfo['Name'],
                              sex: gender,
                              dob: userInfo['Date of Birth'].toString(),
                              email: userInfo['Email'],
                              address: userInfo['Address'],
                              phno: '+91${userInfo['Phone No'].toString()}',
                              fatherPhNo:
                                  userInfo['Parent\'s Phone No(Optional)']
                                      .toString(),
                              spousePhNo: userInfo['Wife\'s Phone No(Optional)']
                                  .toString(),
                              maritalStatus: isUserMarried,
                              photo: "photo",
                              uploadLocation: "leaf village",
                              createdBy: "testUser",
                              createdDate: "2024-11-26T11:26:44.775Z",
                              modifiedBy: "testUser",
                              modifiedDate: "2024-11-26T11:26:44.775Z");

                          final userReq = user.toJson();

                          if (arePhoneNumbersUnique == true &&
                              arePhoneNumbersUnique2 == true) {
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
                              final val = await ref
                                  .read(registerUserProvider(userReq).future);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);

                              if (val.status == 'Success') {
                                // Navigator.popAndPushNamed(context, 'LogIn');
                                Navigator.popAndPushNamed(
                                    context, 'StateOfScreen');
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Registration failed!')),
                                );
                              }
                            } catch (ex) {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context); // Close loading dialog
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $ex')),
                              );
                              debugPrint('Error: $ex');
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Phone numbers must be unique'),
                            ));
                          }
                        }
                      },
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 40,
                          child: const Center(child: Text('Submit')))),
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       // print('the phone no is $phoneNo');
                  //       if (formKey.currentState!.validate()) {
                  //         Map<dynamic, dynamic> userInfo =
                  //             ref.read(userDataProvider.notifier).state;
                  //         print('we are inside of lib/mobile/presentation');
                  //         //
                  //         //phone number uniqueness validation
                  //         if (userInfo['Parent\'s Phone No(Optional)'] !=
                  //                 null &&
                  //             userInfo['Parent\'s Phone No(Optional)']
                  //                 .toString()
                  //                 .isNotEmpty) {
                  //           if (userInfo['Phone No'] ==
                  //                   userInfo['Parent\'s Phone No(Optional)'] ||
                  //               userInfo['Parent\'s Phone No(Optional)'] ==
                  //                   userInfo['Wife\'s Phone No(Optional)']) {
                  //             arePhoneNumbersUnique = false;
                  //           } else {
                  //             arePhoneNumbersUnique = true;
                  //           }
                  //         }
                  //         if (userInfo['Wife\'s Phone No(Optional)'] != null &&
                  //             userInfo['Wife\'s Phone No(Optional)']
                  //                 .toString()
                  //                 .isNotEmpty) {
                  //           if (userInfo['Phone No'] ==
                  //                   userInfo['Wife\'s Phone No(Optional)'] ||
                  //               userInfo['Parent\'s Phone No(Optional)'] ==
                  //                   userInfo['Wife\'s Phone No(Optional)']) {
                  //             arePhoneNumbersUnique2 = false;
                  //           } else {
                  //             arePhoneNumbersUnique2 = true;
                  //           }
                  //         }
                  //         //phone number uniqueness validation
                  //         UserInfoReq user = UserInfoReq(
                  //             name: userInfo['Name'],
                  //             sex: gender,
                  //             dob: userInfo['Date of Birth'].toString(),
                  //             email: userInfo['Email'],
                  //             address: userInfo['Address'],
                  //             phno: '+91${userInfo['Phone No'].toString()}',
                  //             fatherPhNo:
                  //                 userInfo['Parent\'s Phone No(Optional)']
                  //                     .toString(),
                  //             spousePhNo: userInfo['Wife\'s Phone No(Optional)']
                  //                 .toString(),
                  //             maritalStatus: isUserMarried,
                  //             photo: "photo",
                  //             uploadLocation: "leaf village",
                  //             createdBy: "testUser",
                  //             createdDate: "2024-11-26T11:26:44.775Z",
                  //             modifiedBy: "testUser",
                  //             modifiedDate: "2024-11-26T11:26:44.775Z");

                  //         final userReq = user.toJson();

                  //         if (arePhoneNumbersUnique == true &&
                  //             arePhoneNumbersUnique2 == true) {
                  //           showDialog(
                  //             barrierDismissible: false,
                  //             barrierColor: Colors.transparent,
                  //             context: context,
                  //             builder: (context) {
                  //               return Dialog(
                  //                 backgroundColor: Colors.transparent,
                  //                 alignment: Alignment.center,
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(12),
                  //                 ),
                  //                 child: SizedBox(
                  //                   height: MediaQuery.of(context).size.height,
                  //                   width: MediaQuery.of(context).size.width,
                  //                   child: const Center(
                  //                     child: CircularProgressIndicator(),
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //           );

                  //           try {
                  //             final val = await ref
                  //                 .read(registerUserProvider(userReq).future);

                  //             // ignore: use_build_context_synchronously
                  //             Navigator.pop(context);

                  //             if (val.status == 'Success') {
                  //               // Navigator.popAndPushNamed(context, 'LogIn');
                  //               Navigator.popAndPushNamed(
                  //                   context, 'StateOfScreen');
                  //             } else {
                  //               // ignore: use_build_context_synchronously
                  //               ScaffoldMessenger.of(context).showSnackBar(
                  //                 const SnackBar(
                  //                     content: Text('Registration failed!')),
                  //               );
                  //             }
                  //           } catch (ex) {
                  //             // ignore: use_build_context_synchronously
                  //             Navigator.pop(context); // Close loading dialog
                  //             // ignore: use_build_context_synchronously
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               SnackBar(content: Text('Error: $ex')),
                  //             );
                  //             debugPrint('Error: $ex');
                  //           }
                  //         } else {
                  //           ScaffoldMessenger.of(context)
                  //               .showSnackBar(const SnackBar(
                  //             content: Text('Phone numbers must be unique'),
                  //           ));
                  //         }
                  //       }
                  //     },
                  //     child: Container(
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           gradient: LinearGradient(
                  //               colors: [
                  //                 // Color(0xFF5189B8), Color(0xFF0D256E)
                  //                 Theme.of(context)
                  //                     .colorScheme
                  //                     .primaryContainer,
                  //                 Theme.of(context)
                  //                     .colorScheme
                  //                     .secondaryContainer
                  //               ],
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight)),
                  //       width: MediaQuery.of(context).size.width - 120,
                  //       child: const Center(
                  //           child: Text(
                  //         'Submit',
                  //         style: TextStyle(color: Colors.white),
                  //         // style: TextStyle(color: Colors.white, fontSize: 17),
                  //       )),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      const Text('Already have an account?'),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'LogIn');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              // color: Color(0xFF0D256E),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // );
    );
  }

  pickImage() async {
    try {
      var status = await Permission.photos.request();
      if (status.isDenied) {
        // You might want to show a dialog explaining why you need this permission
      }
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagePath = File(image.path);
      setState(() {
        profilePic = imagePath;
      });
    } catch (ex) {
      debugPrint('exception occured $ex');
    }
  }
}

class CustomClipperTool extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 4.25);

    var firstControlPoint = Offset(size.width / 4, size.height / 3);
    var firstEndPoint = Offset(size.width / 2, size.height / 3 - 60);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height / 4 - 65);
    var secondEndPoint = Offset(size.width, size.height / 3 - 40);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
