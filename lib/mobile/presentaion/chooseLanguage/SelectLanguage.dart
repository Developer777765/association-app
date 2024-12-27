import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/core/utils/floatingContainer.dart';
import 'package:temple_app/mobile/presentaion/login/login_screen.dart';

class SelectLanguage extends ConsumerStatefulWidget {
  @override
  ConsumerState<SelectLanguage> createState() {
    return SelectLanguageState();
  }
}

class SelectLanguageState extends ConsumerState<SelectLanguage> {
  @override
  build(context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            // SizedBox(
            // width: MediaQuery.of(context).size.width,
            // child:
            //  Column(
            //   children: [

            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Text('Choose your desired language!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                ),
                const Spacer()
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/chooseLanguage2.PNG',
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: 150,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: AnimatedFloatingContainer(
                              label: 'தமிழ்',
                            ),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: GestureDetector(
                            onTap: () {},
                            child: AnimatedFloatingContainer(
                              label: 'English',
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(child: Text('Continue')),
                ),
              ),
            )
            //   ],
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
