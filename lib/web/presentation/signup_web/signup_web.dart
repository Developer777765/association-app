// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, use_build_context_synchronously, unused_element

import 'dart:convert';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temple_app/common_widget/responsive_widget.dart';
import 'package:temple_app/utils/loader.dart';
import 'package:temple_app/web/presentation/login_web/login_screen_web.dart';
import '../../../common_widget/button.dart';
import '../../../core/utils/CustomTextField.dart';
import '../../../data/dtos/userInfoReq.dart';
import '../../../data/repository/login_repository.dart';
import '../../../mobile/presentaion/signUpUser/signUpUser.dart';
import '../../../utils/size_utils.dart';
import '../../router_web/route_enums_web.dart';

class SignupWeb extends ConsumerStatefulWidget {
  const SignupWeb({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupWebState();
}

class _SignupWebState extends ConsumerState<SignupWeb> {
  TextEditingController dobContoller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController parentsPhoneController = TextEditingController();
  TextEditingController wifePhoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        dobContoller.text =
            "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = TSizeUtils.hPercent(100, context: context);
    double sizeWidth = TSizeUtils.wPercent(100, context: context);
    bool isUserMarried = ref.watch(maritalStatusProvider);

    String gender = 'M';
    final formKey = GlobalKey<FormState>();
    List<String> genders = ['Male', 'Female', 'Other'];
    File? profilePic;
    bool arePhoneNumbersUnique = true;
    bool arePhoneNumbersUnique2 = true;
    bool hasNetworkChanged = true;

    pickImage() async {
      try {
        var status = await Permission.photos.request();
        if (status.isDenied) {
          // You might want to show a dialog explaining why you need this permission
        }
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        setState(() {
          profilePic = imagePath;
        });
      } catch (ex) {
        debugPrint('exception occured $ex');
      }
    }

    mobileregisterCall() async {
      if (nameController.value.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plase enter your name')),
        );
        return;
      }
      if (phoneController.value.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plase enter your number')),
        );
        return;
      }
      if (addressController.value.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plase enter your address')),
        );
        return;
      }
      if (emailController.value.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plase enter your email')),
        );
        return;
      }
      UserInfoReq user = UserInfoReq(
        name: nameController.text,
        sex: gender,
        dob: dobContoller.text,
        email: emailController.text,
        address: addressController.text,
        phno: '+91${phoneController.text}',
        fatherPhNo: parentsPhoneController.text,
        spousePhNo: wifePhoneController.text,
        maritalStatus: isUserMarried,
        photo: "photo",
        uploadLocation: "leaf village",
        createdBy: "testUser",
        createdDate: "2024-11-26T11:26:44.775Z",
        modifiedBy: "testUser",
        modifiedDate: "2024-11-26T11:26:44.775Z",
      );

      if (arePhoneNumbersUnique == true && arePhoneNumbersUnique2 == true) {
        TUtility().loader(context);
        try {
          final val = await LoginRepository()
              .registerUserMobile(userInfoReqToJson(user));
          Navigator.pop(context);
          if (val.status == 'Success') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreenWeb()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration failed!')),
            );
          }
        } catch (ex) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $ex')),
          );
          debugPrint('Error: $ex');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Phone numbers must be unique'),
        ));
      }
    }

    registerCall() async {
      if (formKey.currentState!.validate()) {
        Map<dynamic, dynamic> userInfo =
            ref.read(userDataProvider.notifier).state;
        print('we are inside of lib/mobile/presentation');
        //
        //phone number uniqueness validation
        if (userInfo['Parent\'s Phone No(Optional)'] != null &&
            userInfo['Parent\'s Phone No(Optional)'].toString().isNotEmpty) {
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
            userInfo['Wife\'s Phone No(Optional)'].toString().isNotEmpty) {
          if (userInfo['Phone No'] == userInfo['Wife\'s Phone No(Optional)'] ||
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
            fatherPhNo: userInfo['Parent\'s Phone No(Optional)'].toString(),
            spousePhNo: userInfo['Wife\'s Phone No(Optional)'].toString(),
            maritalStatus: isUserMarried,
            photo: "photo",
            uploadLocation: "leaf village",
            createdBy: "testUser",
            createdDate: "2024-11-26T11:26:44.775Z",
            modifiedBy: "testUser",
            modifiedDate: "2024-11-26T11:26:44.775Z");

        final userReq = user.toJson();

        if (arePhoneNumbersUnique == true && arePhoneNumbersUnique2 == true) {
          TUtility().loader(context);

          try {
            final val = await ref.read(registerUserProvider(userReq).future);

            Navigator.pop(context);

            if (val.status == 'Success') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreenWeb()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration failed!')),
              );
            }
          } catch (ex) {
            Navigator.pop(context); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $ex')),
            );
            debugPrint('Error: $ex');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Phone numbers must be unique'),
          ));
        }
      }
    }

    return Scaffold(
      body: Form(
        key: MediaQuery.of(context).size.width < 700 ? null : formKey,
        child: ResponsiveWidget(
            desktop: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await pickImage();
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
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
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Let\'s register your profile!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xFF0D256E)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.25,
                      child: CustomTextField(
                        isFieldNotEditable: false,
                        label: 'Name',
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.25,
                      child: CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        isFieldNotEditable: false,
                        label: 'Phone No',
                        hint: 'Enter your phone number',
                        keyBoardType: TextInputType.phone,
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.25,
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.25,
                      child: CustomTextField(
                        label: 'Date of Birth',
                        hint: 'DD-MM-YYYY',
                        isFieldNotEditable: true,
                        controller: TextEditingController(),
                        initialText: 'DD-MM-YYYY',
                      ),
                    ),
                    Container(
                        height: sizeHeight * 0.1,
                        width: sizeWidth * 0.25,
                        child: CustomTextField(
                            isFieldNotEditable: false, label: 'Address')),
                    Container(
                        height: sizeHeight * 0.1,
                        width: sizeWidth * 0.25,
                        child: CustomTextField(
                          label: 'Email',
                          isFieldNotEditable: false,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.25,
                      child: CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        isFieldNotEditable: false,
                        label: 'Parent\'s Phone No(Optional)',
                        hint: 'Enter Father\'s (or) Mother\'s phone number',
                        keyBoardType: TextInputType.phone,
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.25,
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
                    ),
                    isUserMarried
                        ? Container(
                            height: sizeHeight * 0.1,
                            width: sizeWidth * 0.25,
                            child: CustomTextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              isFieldNotEditable: false,
                              label: 'Wife\'s Phone No(Optional)',
                              hint: 'Enter Wife\'s phone number',
                              keyBoardType: TextInputType.phone,
                            ),
                          )
                        : Container(
                            height: sizeHeight * 0.1,
                            width: sizeWidth * 0.25,
                          ),
                  ],
                ),
                SizedBox(
                  height: sizeHeight * 0.15,
                ),
                Container(
                  height: sizeHeight * 0.1,
                  width: sizeWidth * 0.25,
                  child: Button(
                      text: "Submit", //web
                      onPressed: () async {
                        registerCall();
                      }),
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
                        context.goNamed(Routes.loginWeb.name);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xFF0D256E),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
            mobile: SingleChildScrollView(
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
                        color: Color(0xFF0D256E)),
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
                  CommomTextFormField(
                    controller: nameController,
                    labelText: 'Name',
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // CommomTextFormField(
                  //   controller: phoneController,
                  //   labelText: 'Phone',
                  //   keyboardType: TextInputType.number,
                  // ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                  const SizedBox(height: 30),
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
                  const SizedBox(
                    height: 30,
                  ),
                  CommomTextFormField(
                    controller: parentsPhoneController,
                    labelText: 'Parent\'s Phone No(Optional)',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  isUserMarried
                      ? CommomTextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: wifePhoneController,
                          labelText: 'Wife\'s Phone No(Optional)',
                          keyboardType: TextInputType.number,
                        )
                      : const SizedBox(height: 0),
                  SizedBox(
                    height: isUserMarried ? 30 : 1,
                  ),
                  CommomTextFormField(
                    controller: dobContoller,
                    labelText: 'Date of Birth',
                    readOnly: true,
                    onTap: () async {
                      _selectDate(context);
                    },
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
                  CommomTextFormField(
                    controller: addressController,
                    labelText: 'Address',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommomTextFormField(
                    controller: emailController,
                    labelText: 'Email',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: sizeHeight * 0.08,
                    width: sizeWidth * 0.87,
                    child: Button(
                        text: "Submit", //mobile
                        onPressed: () async {
                          mobileregisterCall();
                          print("MobilePRibnt");
                        }),
                  ),
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
                          context.goNamed(Routes.loginWeb.name);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Color(0xFF0D256E),
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
            tablet: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await pickImage();
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
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
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Let\'s register your profile!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xFF0D256E)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.3,
                      child: CustomTextField(
                        isFieldNotEditable: false,
                        label: 'Name',
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.3,
                      child: CustomTextField(
                        isFieldNotEditable: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        label: 'Phone No',
                        hint: 'Enter your phone number',
                        keyBoardType: TextInputType.phone,
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.3,
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.3,
                      child: CustomTextField(
                        label: 'Date of Birth',
                        hint: 'DD-MM-YYYY',
                        isFieldNotEditable: true,
                        controller: TextEditingController(),
                        initialText: 'DD-MM-YYYY',
                      ),
                    ),
                    Container(
                        height: sizeHeight * 0.1,
                        width: sizeWidth * 0.3,
                        child: CustomTextField(
                            isFieldNotEditable: false, label: 'Address')),
                    Container(
                        height: sizeHeight * 0.1,
                        width: sizeWidth * 0.3,
                        child: CustomTextField(
                          label: 'Email',
                          isFieldNotEditable: false,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.3,
                      child: CustomTextField(
                        isFieldNotEditable: false,
                           inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        label: 'Parent\'s Phone No(Optional)',
                        hint: 'Enter Father\'s (or) Mother\'s phone number',
                        keyBoardType: TextInputType.phone,
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.1,
                      width: sizeWidth * 0.32,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
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
                    ),
                    isUserMarried
                        ? Container(
                            height: sizeHeight * 0.1,
                            width: sizeWidth * 0.3,
                            child: CustomTextField(
                              isFieldNotEditable: false,
                                 inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                              label: 'Wife\'s Phone No(Optional)',
                              hint: 'Enter Wife\'s phone number',
                              keyBoardType: TextInputType.phone,
                            ),
                          )
                        : Container(
                            height: sizeHeight * 0.1,
                            width: sizeWidth * 0.25,
                          ),
                  ],
                ),
                SizedBox(
                  height: sizeHeight * 0.15,
                ),
                Container(
                  height: sizeHeight * 0.1,
                  width: sizeWidth * 0.25,
                  child: Button(
                      text: "Submit", //tablet
                      onPressed: () async {
                        registerCall();
                      }),
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
                        context.goNamed(Routes.loginWeb.name);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xFF0D256E),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
