import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temple_app/core/utils/CustomTextField.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';
import 'package:temple_app/data/dtos/mob_num_uni_req_dto.dart';
import 'package:temple_app/data/dtos/upload_img_req_dto.dart';
import 'package:temple_app/mobile/presentaion/captureImage/camera_capture.dart';
import 'package:temple_app/mobile/presentaion/splash/splash_screen.dart';
import 'package:temple_app/mobile/presentaion/successScreen/state_of_screen.dart';
import 'package:temple_app/services/networkStatus.dart';
import '../../../data/dtos/userInfoReq.dart';
import '../../../data/repository/login_repository.dart';

final maritalStatusProvider = StateProvider<bool>((ref) => false);
final phoneErrorMsgProvider = StateProvider<String>((ref) => '');
final profileProvider = StateProvider<Profile>((ref) {
  return Profile();
});
final profilePictureProvider = StateProvider<ProfilePicUploadReq>((ref) {
  return ProfilePicUploadReq();
});

final uniquImgId = StateProvider<String>((ref) {
  return '';
});

final changeCityBlock = StateProvider<bool>((ref) {
  return false;
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

// ignore: must_be_immutable
class SignUp extends ConsumerStatefulWidget {
  bool isItSignUp;
  String? profilePictureUrl;
  SignUp({super.key, required this.isItSignUp, this.profilePictureUrl});
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
  String completeAddress = '';
  File? profilePic;
  bool hasNetworkChanged = true;
  String cityBlockDisitrict = '';
  List<dynamic>? postOfficesOfEditProfile;
  var userEditAddress;
  var userEdit;
  var userEditProfile;

  @override
  void initState() {
    super.initState();
    if (!widget.isItSignUp) {
      loadPostalCodeDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasCityBlockChanged = ref.watch(changeCityBlock);
    var checkNetworkStatus = ref.watch(networkStatusProvider);
    bool isUserMarried = ref.watch(maritalStatusProvider);
    List cities = ref.watch(citiesProvider);
    String stateName = ref.watch(nameOfStateProvider);
    String countryName = ref.watch(countryProvider);
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
                  Text(
                    widget.isItSignUp
                        ? 'Let\'s register your profile!'
                        : 'Edit Profile',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  Text(
                    widget.isItSignUp
                        ? 'Enter Your Personal Data to Create One'
                        : '',
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // await pickImage();
                      bringForwardModalBottomSheet(context);
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          child: profilePic !=
                                  null // Show selected image if available
                              ? ClipOval(
                                  child: Image.file(
                                    profilePic!,
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : widget
                                      .isItSignUp // Show default image if signing up
                                  ? const Icon(
                                      Icons.person_sharp,
                                      size: 50,
                                    )
                                  : widget.profilePictureUrl !=
                                          null // Show existing profile picture if editing
                                      ? ClipOval(
                                          child: Image.network(
                                            widget.profilePictureUrl!,
                                            width: 140,
                                            height: 140,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Icon(Icons
                                          .person_sharp), // Show default if no profile pic
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
                    //TODO: testing for edit profile
                    controller: widget.isItSignUp
                        ? null
                        : TextEditingController(
                            text: userEditProfile.name ?? ''),
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
                    //TODO: //testing for edit profile
                    controller: widget.isItSignUp
                        ? null
                        : TextEditingController(
                            text: userEditProfile.phno.substring(3, 13) ?? ''),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    label: 'Parent\'s Phone No(Optional)',
                    hint: 'Enter Father\'s (or) Mother\'s phone number',
                    isFieldNotEditable: false,
                    keyBoardType: TextInputType.phone,
                    //TODO: //testing for edit profile
                    controller: widget.isItSignUp
                        ? null
                        : TextEditingController(
                            text: userEditProfile.fatherPhNo == 'null' ||
                                    userEditProfile.fatherPhNo == null
                                ? ''
                                : userEditProfile.fatherPhNo),
                  ),
                  const SizedBox(height: 30),
                  isUserMarried
                      ? CustomTextField(
                          label: 'Wife\'s Phone No(Optional)',
                          hint: 'Enter Wife\'s phone number',
                          isFieldNotEditable: false,
                          keyBoardType: TextInputType.phone,
                          //TODO: //testing for edit profile
                          controller: widget.isItSignUp
                              ? null
                              : TextEditingController(
                                  text: userEditProfile.spousePhNo ?? ''),
                        )
                      : const SizedBox(height: 0),
                  SizedBox(
                    height: isUserMarried ? 30 : 1,
                  ),
                  CustomTextField(
                    label: 'Date of Birth',
                    hint: 'DD-MM-YYYY',
                    isFieldNotEditable: true,
                    initialText: 'DD-MM-YYYY',
                    //TODO: //testing for edit profile
                    controller: widget.isItSignUp
                        ? null
                        : TextEditingController(
                            text: userEditProfile.dob.substring(0, 10)),
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
                          decoration: CustomDropdownDecoration(
                              closedFillColor: Colors.transparent,
                              expandedFillColor:
                                  Theme.of(context).colorScheme.outlineVariant,
                              headerStyle: const TextStyle(
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
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    label: 'Email',
                    isFieldNotEditable: false,
                    //TODO: //testing for edit profile
                    controller: widget.isItSignUp
                        ? null
                        : TextEditingController(text: userEditProfile.email),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //************************************** */
                  CustomTextField(
                    label: 'PinCode',
                    isFieldNotEditable: false,
                    keyBoardType: TextInputType.phone,
                    //TODO: //testing for edit profile
                    controller: widget.isItSignUp
                        ? null
                        : TextEditingController(
                            text: userEditAddress['Pincode']),
                    //TODO: //testing for edit profile
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    label: 'House no.,Street name,',
                    isFieldNotEditable: false,
                    //TODO: //testing for edit profile
                    controller: widget.isItSignUp
                        ? null
                        : TextEditingController(
                            text: userEditAddress['Street Block']),
                    //TODO: //testing for edit profile
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
                          decoration: CustomDropdownDecoration(
                              closedFillColor: Colors.transparent,
                              expandedFillColor:
                                  Theme.of(context).colorScheme.outlineVariant,
                              headerStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                          hintText: widget.isItSignUp
                              ? 'City, Block, District,'
                              : userEditAddress['City Block'],
                          items: hasCityBlockChanged
                              ? cities
                              : postOfficesOfEditProfile,
                          onChanged: (val) {
                            hasCityBlockChanged = true;
                            cityBlockDisitrict = val;
                            ref.read(changeCityBlock.notifier).state = true;
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(top: 20, left: 8),
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.outline)),
                            child: Text(widget.isItSignUp
                                ? stateName
                                : userEditAddress['State Block']),
                          )),
                          const SizedBox(
                            width: 7,
                          ),
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(top: 20, left: 8),
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.outline)),
                            child: Text(widget.isItSignUp
                                ? countryName
                                : userEditAddress['Country Block']),
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //**************************************** */
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () async {
                        String? uniqueIdOfPic;
                        if (profilePic != null) {
                          ProfilePicUploadReq pickedPicture =
                              ref.read(profilePictureProvider);
                          FormData form = FormData.fromMap(
                            {
                              "File": await MultipartFile.fromFile(
                                  pickedPicture.uploadFile!.path,
                                  filename: pickedPicture.fileName),
                              "CompanyName": pickedPicture.companyName,
                              "CompanyID": pickedPicture.companyId,
                              "UnitID": pickedPicture.unitId,
                              "Category": pickedPicture.category,
                              "Keyvalue": pickedPicture.keyValue,
                              "KeyID": pickedPicture.keyId,
                              "FileType": pickedPicture.fileType,
                              "Createdby": pickedPicture.createdBy,
                              "Path": pickedPicture.path,
                              "FileName": pickedPicture.fileName,
                            },
                          );
                          //TODO: disabled for now(photo upload)
                          uniqueIdOfPic = await ref
                              .read(loginRepositoryProvider)
                              .uploadProfilePicture(form);
                          //TODO: disabled for now(photo upload)
                          //###################disabled for now######################
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('No picture selected'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                        //###################disabled for now######################
                        if (formKey.currentState!.validate()) {
                          Map<dynamic, dynamic> userInfo =
                              ref.read(userDataProvider.notifier).state;

                          //*************phone number uniqueness validation*************
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
                          //*************phone number uniqueness validation*************

                          //*************address validation************ */

                          if (userInfo['PinCode'] != null &&
                              userInfo['House no.,Street name,'] != null) {
                            completeAddress =
                                '${userInfo['House no.,Street name,']}, ${hasCityBlockChanged ? cityBlockDisitrict : userEditAddress['City Block']} (${userInfo['PinCode']}), $stateName, $countryName';
                          }
                          //*************address validation************ */
                          UserInfoReq user = UserInfoReq(
                              id: userEditProfile?.id ?? 0,
                              name: userInfo['Name'],
                              sex: gender,
                              dob: userInfo['Date of Birth']
                                  .toString()
                                  .substring(0, 10),
                              email: userInfo['Email'],
                              address: completeAddress,
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
                              modifiedDate: "2024-11-26T11:26:44.775Z",
                              profilePic: uniqueIdOfPic,
                              isApproval: true,
                              uniqueId: ref.read(companyId));

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
                              CheckNumberUniquenessReq req =
                                  CheckNumberUniquenessReq(
                                      mobileNumber:
                                          '+91${userInfo['Phone No'].toString()}',
                                      uniqueId: ref.read(companyId));
                              var reqDto = req.toJson();
                              var numberChecker = await ref.read(
                                  mobNumberUniquenessProvider(reqDto).future);
                              bool isMobileNumberUnique =
                                  numberChecker.result.isNumberUnique;
                              int existinguserId = numberChecker.result.userId;
                              var val;
                              if (widget.isItSignUp) {
                                if (isMobileNumberUnique) {
                                  val = await ref.read(
                                      registerUserProvider(userReq).future);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);

                                  if (val.status == 'Success') {
                                    int? id = val.result![0].id;
                                    // Navigator.popAndPushNamed(context, 'LogIn');
                                    //****************** */
                                    final profileBox =
                                        await Hive.openBox('userIdBox');
                                    await profileBox.put('userId', id);
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StateOfScreen(
                                          isItEditProfile: false);
                                    }));
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Registration failed!')),
                                    );
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'The mobile number is already registered with another profile. Try a new one.')),
                                  );
                                }
                              }
                              //TODO: this is for edit profile
                              else {
                                if (!isMobileNumberUnique &&
                                    existinguserId == userEditProfile.id) {
                                  val = await ref.read(
                                      updateUserProfileProvider(userReq)
                                          .future);
                                  if (val.status == '200') {
                                    ref.read(changeCityBlock.notifier).state =
                                        false;
                                    var personBox =
                                        Hive.box<UserProfile>('userProfileBox');
                                    await personBox.clear();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StateOfScreen(
                                          isItEditProfile: false);
                                    }));
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Registration failed!')),
                                    );
                                  }
                                } else if (isMobileNumberUnique) {
                                  val = await ref.read(
                                      updateUserProfileProvider(userReq)
                                          .future);
                                  if (val.status == '200') {
                                    ref.read(changeCityBlock.notifier).state =
                                        false;
                                    var personBox =
                                        Hive.box<UserProfile>('userProfileBox');
                                    await personBox.clear();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StateOfScreen(
                                          isItEditProfile: false);
                                    }));
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Registration failed!')),
                                    );
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'The mobile number is already registered with another profile. Try a new one.')),
                                  );
                                }
                              }
                              //TODO: this is for edit profile
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
                  const SizedBox(
                    height: 30,
                  ),
                  //TODO: for edit profile testing
                  widget.isItSignUp
                      ?
                      //TODO: for edit profile testing
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                          ],
                        )
                      : const SizedBox(
                          height: 1,
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
      if (Platform.isAndroid) {
        int sdkVersion = int.parse(
            (await Process.run('getprop', ['ro.build.version.sdk']))
                .stdout
                .toString()
                .trim());
        if (sdkVersion < 33) {
          PermissionStatus statusOfPermission = await Permission.storage.status;
          if (statusOfPermission.isDenied ||
              statusOfPermission.isPermanentlyDenied) {
            //requesting permission if denied
            statusOfPermission = await Permission.storage.request();
            if (statusOfPermission.isDenied) {
              return;
            }
            if (statusOfPermission.isPermanentlyDenied) {
              openAppSettings();
              return;
            }
          }
          if (statusOfPermission.isGranted) {
            filePicker();
          }
        } else {
          PermissionStatus statusOfPermission = await Permission.photos.status;
          if (statusOfPermission.isDenied ||
              statusOfPermission.isPermanentlyDenied) {
            //requesting permission if denied
            statusOfPermission = await Permission.photos.request();
            if (statusOfPermission.isDenied) {
              return;
            }
            if (statusOfPermission.isPermanentlyDenied) {
              openAppSettings();
              return;
            }
          }
          if (statusOfPermission.isGranted) {
            filePicker();
          }
        }
      }
    } catch (ex) {
      debugPrint('exception occured $ex');
    }
  }

  update() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    if (image == null) return;
    String fileExtension = image.path.split('.').last.toLowerCase();
    ProfilePicUploadReq profilePicture = ProfilePicUploadReq(
        companyId: 1046, //
        category: "picture", //
        companyName: "Assocy", //
        createdBy: "user", //
        fileType: fileExtension, //
        keyId: 15, //
        keyValue: "person picture", //
        path: "imagePath", //
        unitId: '17', //
        fileName: image.name, //
        uploadFile: file);
    ref.read(profilePictureProvider.notifier).state = profilePicture;
    final imagePath = File(image.path);
    setState(() {
      profilePic = imagePath;
    });
  }

  filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'jpeg', 'png', 'gif'],
    );
    File file = File(result!.files.single.path!);
    String fileExtension = file.path.split('.').last.toLowerCase();
    ProfilePicUploadReq profilePicture = ProfilePicUploadReq(
        companyId: 1046, //
        category: "picture", //
        companyName: "Assocy", //
        createdBy: "user", //
        fileType: fileExtension, //
        keyId: 15, //
        keyValue: "person picture", //
        path: "imagePath", //
        unitId: '17', //
        fileName: result.files.single.name, //
        uploadFile: file);
    ref.read(profilePictureProvider.notifier).state = profilePicture;
    final imagePath = File(file.path);
    setState(() {
      profilePic = imagePath;
    });
  }

  separateAddress(String completeAddress) {
    String address = completeAddress;
    RegExp pincodeRegex = RegExp(r'\((\d+)\)');
    String? pincode = pincodeRegex.firstMatch(address)?.group(1);
    address = address.replaceAll(RegExp(r'\(\d+\)'), '').trim();
    List<String> parts = address.split(',');
    parts = parts
        .where((element) => element.trim().isNotEmpty)
        .map((e) => e.trim())
        .toList();
    String houseStreetBlock = parts.take(2).join(', ');
    String cityBlockDistrict = parts.sublist(2, parts.length - 2).join(', ');
    String stateBlock = parts[parts.length - 2];
    String countryBlock = parts.last;

    return {
      "Street Block": houseStreetBlock,
      "City Block": cityBlockDistrict,
      "State Block": stateBlock,
      "Country Block": countryBlock,
      "Pincode": pincode
    };
  }

  void loadPostalCodeDetails() async {
    userEdit = Hive.box<UserProfile>('UserProfileBox');
    userEditProfile = userEdit.getAt(0);
    userEditAddress = separateAddress(userEditProfile!.address!);

    var result = await ref
        .read(loginRepositoryProvider)
        .getPostalCodeDetails(userEditAddress['Pincode']);

    List postOffices = result['PostOffice'];
    setState(() {
      postOfficesOfEditProfile = List.generate(postOffices.length, (index) {
        return '${postOffices[index]['Name']}, ${postOffices[index]['Taluk']}, ${postOffices[index]['District']}';
      }, growable: true);
    });
  }

  void bringForwardModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Select profile picture',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CameraCapture()));
                      },
                      child: const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera,
                              size: 30,
                            ),
                            Text('Camera')
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await pickImage();
                      },
                      child: const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 30,
                            ),
                            Text('Gallery')
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 30,
                            ),
                            Text('Avatar')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
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
