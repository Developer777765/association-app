// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/mobile/presentaion/dashboard/dashboard_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:temple_app/mobile/presentaion/home_redefined/HomeScreenV2.dart';
import 'package:temple_app/mobile/presentaion/transaction/transactions.dart';
import 'package:temple_app/mobile/presentaion/userProfile/profile_screen.dart';
import 'package:temple_app/services/customPainter.dart';

import '../../../common_widget/apptheme.dart';

class TabbarWidget extends ConsumerStatefulWidget {
  const TabbarWidget({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends ConsumerState<TabbarWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreenVersion2(),
    // DashboardScreen(),
    // Text(
    //   'No transactions yet!',
    //   style: optionStyle,
    // ),
    Transactions(),

    ProfileScreen(),
    // Text(
    //   'Under Implementation',
    //   style: optionStyle,
    // ),
    Center(
        child: Icon(
      Icons.warning_amber_rounded,
      size: 60,
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8.0),
        // color: Theme.of(context).colorScheme.primaryContainer,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        height: MediaQuery.of(context).size.height * 0.085,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: SizedBox(
                    height: double.infinity - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: _selectedIndex == 0
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Colors.black,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                : Colors.black,
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: SizedBox(
                    height: double.infinity - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: _selectedIndex == 1
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Colors.black,
                        ),
                        Text(
                          'Payments',
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                : Colors.black,
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                child: SizedBox(
                    height: double.infinity - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: _selectedIndex == 2
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Colors.black,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                : Colors.black,
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                child: SizedBox(
                    height: double.infinity - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.more_rounded,
                          color: _selectedIndex == 3
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Colors.black,
                        ),
                        Text(
                          'More',
                          style: TextStyle(
                            color: _selectedIndex == 3
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                : Colors.black,
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      //       // color: Color.fromARGB(255, 229, 232, 235),
      //       color: Theme.of(context).colorScheme.primaryContainer),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         gap: 3,
      //         // curve: Curves.decelerate,
      //         curve: Curves.ease,
      //         // activeColor: Colors.white,
      //         activeColor: Theme.of(context).colorScheme.secondaryContainer,
      //         iconSize: 15,
      //         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      //         duration: Duration(microseconds: 400),
      //         // tabBackgroundGradient: LinearGradient(
      //         //   colors: [
      //         //     // AppTheme.primayColor,
      //         //     // Color.fromARGB(255, 65, 102, 133),
      //         //     Theme.of(context).colorScheme.primaryContainer,
      //         //     Theme.of(context).colorScheme.secondaryContainer,
      //         //   ],
      //         //   begin: Alignment.centerRight,
      //         //   end: Alignment.centerLeft,
      //         // ),
      //         color: const Color.fromRGBO(37, 37, 37, 0.902),
      //         tabs: [
      //           GButton(
      //             icon: Icons.home_filled,
      //             text: 'Home',
      //             textStyle: TextStyle(
      //                 fontSize: 10,
      //                 // color: Colors.white,
      //                 color: Theme.of(context).colorScheme.secondaryContainer,
      //                 fontWeight: FontWeight.w600),
      //           ),
      //           GButton(
      //             icon: Icons.history,
      //             text: 'Transactions',
      //             textStyle: TextStyle(
      //                 fontSize: 10,
      //                 // color: Colors.white,
      //                 color: Theme.of(context).colorScheme.secondaryContainer,
      //                 fontWeight: FontWeight.w600),
      //           ),
      //           GButton(
      //             icon: Icons.account_circle_outlined,
      //             text: 'Profile',
      //             textStyle: TextStyle(
      //                 fontSize: 10,
      //                 // color: Colors.white,
      //                 color: Theme.of(context).colorScheme.secondaryContainer,
      //                 fontWeight: FontWeight.w600),
      //           ),
      //           GButton(
      //             icon: Icons.account_circle_outlined,
      //             text: 'Profile',
      //             textStyle: TextStyle(
      //                 fontSize: 10,
      //                 // color: Colors.white,
      //                 color: Theme.of(context).colorScheme.secondaryContainer,
      //                 fontWeight: FontWeight.w600),
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
