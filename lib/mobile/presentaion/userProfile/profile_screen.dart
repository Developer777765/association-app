import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple_app/common_widget/apptheme.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';
import 'package:temple_app/data/repository/get_register_repository.dart';
import 'package:temple_app/mobile/presentaion/login/login_screen.dart';
import 'package:temple_app/mobile/presentaion/successScreen/state_of_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  build(context) {
    var user = Hive.box<UserProfile>('UserProfileBox');
    var userProfile = user.getAt(0);
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
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Under implementation'),
                                ));
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 50,
                          child: Text(
                            userProfile!.name!.substring(0, 1),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
              const SizedBox(
                height: 30,
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
                            userProfile.fatherPhNo! == 'strng'
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
                            userProfile.spousePhNo!.isEmpty
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
