import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple_app/common_widget/apptheme.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';
import 'package:temple_app/data/dtos/get_img_dto.dart';
import 'package:temple_app/data/dtos/get_img_res_dto.dart';
import 'package:temple_app/data/dtos/upload_img_req_dto.dart';
import 'package:temple_app/data/repository/get_register_repository.dart';
import 'package:temple_app/data/repository/login_repository.dart';
import 'package:temple_app/mobile/presentaion/login/login_screen.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/signUpUser.dart';
import 'package:temple_app/mobile/presentaion/successScreen/state_of_screen.dart';

final imageUrlProvider = StateProvider<String>((ref) {
  return '';
});

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initMethod();
  }

  initMethod() async {
    var user = Hive.box<UserProfile>('UserProfileBox');
    var userProfile = user.getAt(0);
    String picture = userProfile!.profilePic!.toString();
    GetImgReqDto req = GetImgReqDto(
        uniqueId: userProfile.profilePic!.toString(),
        companyId: 1046,
        category: 'picture',
        keyId: 15);

    GetImgResDto result = await ref.read(getImageProvider(req.toJson()).future);
    String imgaeUrl = result.result!.docUrl;
    debugPrint('the picture is $picture');
    ref.read(imageUrlProvider.notifier).state = imgaeUrl;
  }

  var req = GetImgReqDto(
          uniqueId: 'DMS_8dd3b0c1201d41d',
          companyId: 1046,
          category: 'picture',
          keyId: 15)
      .toJson();

  @override
  build(context) {
    var user = Hive.box<UserProfile>('UserProfileBox');
    var userProfile = user.getAt(0);
    var picture = userProfile!.uniqueId;
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, 'HomeScreen');
        return true;
      },
      child: Material(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Container(
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Card(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height / 2.5,
                  // decoration: BoxDecoration(
                  //   borderRadius: const BorderRadius.only(
                  //       bottomLeft: Radius.circular(30),
                  //       bottomRight: Radius.circular(30)),
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       Theme.of(context).colorScheme.primaryContainer,
                  //       Theme.of(context).colorScheme.secondaryContainer,
                  //     ],
                  //     begin: Alignment.centerRight,
                  //     end: Alignment.centerLeft,
                  //   ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, 'HomeScreen');
                              },
                              icon: const Icon(Icons.arrow_back_ios_new_sharp),
                              // color: Colors.white,
                            ),
                            const Spacer(),
                            const Text(
                              'My Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                // color: Colors.white
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                // color: Colors.white,
                              ),
                              onPressed: () async {
                                try {
                                  String url = await getImageUrl();
                                  debugPrint('profile picture url is $url');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp(
                                                isItSignUp: false,
                                                profilePictureUrl: url,
                                              )));
                                } catch (ex) {
                                  debugPrint('the error for editing is $ex');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp(
                                                isItSignUp: false,
                                                // profilePictureUrl: url,
                                              )));
                                }
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder(
                          future: getImageUrl(),
                          builder: (context, snapShot) {
                            if (snapShot.hasError) {
                              return const CircleAvatar(
                                  radius: 50, child: Icon(Icons.person_sharp));
                            } else if (snapShot.hasData) {
                              return CircleAvatar(
                                  radius: 50,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(snapShot.data ?? ''),
                                  ));
                            } else if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text('Loading..'),
                              );
                            } else {
                              return const Text('something went wrong');
                            }
                          },
                        ),
                        const Spacer(),
                        Text(
                          'Hello, ${userProfile.name}!',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            // color: Colors.white
                          ),
                        ),
                        Text(
                          '${userProfile.email}',
                          style: const TextStyle(
                              // fontSize: 18,
                              // color: Colors.white
                              ),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                          leading: Icon(
                            Icons.calendar_month_outlined,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: Text(
                            '${userProfile.dob}',
                            style: const TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.phone,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: Text(
                            '${userProfile.phno} (Mine)',
                            style: const TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.phone,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: Text(
                            userProfile.fatherPhNo! == 'strng' ||
                                    userProfile.fatherPhNo == null
                                ? 'Parent\'s No (not provided)'
                                : '${userProfile.fatherPhNo} (Parent\'s)',
                            style: const TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.phone,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: Text(
                            userProfile.spousePhNo!.isEmpty ||
                                    userProfile.spousePhNo == null
                                ? 'Wife\'s No (not provided)'
                                : '${userProfile.spousePhNo} (Wife\'s)',
                            style: const TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.location_on_sharp,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: Text(
                            '${userProfile.address}',
                            style: const TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: Icon(
                            userProfile.maritalStatus!
                                ? Icons.people_alt
                                : Icons.person,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: Text(
                            userProfile.maritalStatus!
                                ? 'Married'
                                : 'Unmarried',
                            style: const TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: Icon(
                            userProfile.sex! == 'M' ? Icons.male : Icons.female,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: Text(
                            userProfile.sex! == 'M' ? 'Male' : 'Female',
                            style: const TextStyle(fontSize: 18),
                          )),
                      // const Spacer(),
                      ListTile(
                          leading: Icon(
                            Icons.logout_outlined,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          title: GestureDetector(
                            onTap: () async {
                              try {
                                var personBox =
                                    Hive.box<UserProfile>('userProfileBox');
                                await personBox.clear();
                                ref
                                    .read(userProfileProvider.notifier)
                                    .update((state) => null);
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.clear();
                                showCustomDialog();
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.of(context).pop();
                                }).then((val) {
                                  Navigator.popAndPushNamed(context, 'LogIn');
                                });
                              } catch (ex) {
                                debugPrint(
                                    'something went wrong with fetching Hive data: $ex');
                              }
                            },
                            child: const Text(
                              'Log Out',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.orange),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getImageUrl() async {
    var user = Hive.box<UserProfile>('UserProfileBox');
    var userProfile = user.getAt(0);
    var req = GetImgReqDto(
            // uniqueId: 'DMS_8dd3b0c1201d41d',
            uniqueId: userProfile?.profilePic ?? 'null',
            companyId: 1046,
            category: 'picture',
            keyId: 15)
        .toJson();
    GetImgResDto result = await ref.read(getImageProvider(req).future);
    // ref.read(imageUrlProvider.notifier).state = result.result.docUrl;
    return result.result.docUrl;
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

//$$$$$$$$$$$$$$$$$$ photo viewer $$$$$$$$$$$$$$$$$$

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://picsum.photos/250?image=9',
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

//$$$$$$$$$$$$$$$$$$ photo viewer $$$$$$$$$$$$$$$$$$

