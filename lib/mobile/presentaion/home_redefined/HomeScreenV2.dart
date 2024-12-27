import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';
import 'package:temple_app/mobile/presentaion/home_redefined/sections/donate/donations.dart';
import 'package:temple_app/mobile/presentaion/home_redefined/testScreen.dart';

class HomeScreenVersion2 extends ConsumerStatefulWidget {
  const HomeScreenVersion2({super.key});

  @override
  createState() => HomeScreenVersion2State();
}

class HomeScreenVersion2State extends ConsumerState<HomeScreenVersion2> {
  List<String> images = [
    'assets/images/dummy.jpg',
    'assets/images/dance.jpg',
    'assets/images/race.jpeg',
    'assets/images/pongal.jpeg',
    'assets/images/drama.jpg'
  ];

  List<Map<dynamic, String>> eventItems = [
    {
      'event': 'Event 1',
      'subtitle': 'Subtitle of Event 1',
      'desc': 'Description of Event 1',
      'img': 'assets/images/dummy.jpg'
    },
    {
      'event': 'Event 2',
      'subtitle': 'Subtitle of Event 2',
      'desc': 'Description of Event 2',
      'img': 'assets/images/pongal.jpeg',
    },
    {
      'event': 'Event 3',
      'subtitle': 'Subtitle of Event 3',
      'desc': 'Description of Event 3',
      'img': 'assets/images/pongal.jpeg',
    },
    {
      'event': 'Event 4',
      'subtitle': 'Subtitle of Event 4',
      'desc': 'Description of Event 4',
      'img': 'assets/images/pongal.jpeg',
    },
    {
      'event': 'Event 5',
      'subtitle': 'Subtitle of Event 5',
      'desc': 'Description of Event 5',
      'img': 'assets/images/drama.jpg'
    },
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  void _goToNextPage() {
    if (_currentPage < images.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  build(context) {
    List<Widget> donateItems = List.generate(5, (index) {
      return Donation(
          event: 'Event ${index + 1}',
          subtitleOfEvent: 'Subtitle of Event ${index + 1}',
          descriptionOfEvent:
              ' Description of Event ${index + 1} in in more detailed way which explains what this event is about, when it is gonna take place, where it is gonna take place, how much this event costs and so on. With this, anyone who has registered profilfe can view this event and even donate for it if he/she wishes. ',
          image: images[index]);
    });
    DateTime currentTime = DateTime.now();
    String formattedDate = DateFormat('E, d MMM').format(currentTime);
    var user = Hive.box<UserProfile>('UserProfileBox');
    var userProfile = user.getAt(0);
    return Material(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Row(
                children: [
                  Text(
                    'Hi, ${userProfile!.name}!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_active,
                      size: 30.0,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TestScreen();
                      }));
                    },
                  )
                ],
              ),
              Text(formattedDate),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            // color: const Color(0xFFF88906),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(25)),
                        height: 80,
                        child: const Center(
                            child: ListTile(
                                leading: Icon(Icons.flag),
                                title: Text('Upcoming Events'))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          // color: const Color(
                          //   0xFFDD2219,
                          // ),
                          borderRadius: BorderRadius.circular(25)),
                      height: 80,
                      child: const Center(child: Text('Participate in Events')
                          // Icon(Icons.payment)
                          //  Text('Event')
                          ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(25)),
                      height: 80,
                      child: Center(
                          child: IconButton(
                        icon: const Icon(
                          Icons.monetization_on,
                          size: 30,
                        ),
                        onPressed: () {},
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(25)),
                      height: 80,
                      child: const Center(
                          child: ListTile(
                              leading: Icon(Icons.money),
                              title: Text('Pending Payment'))),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(25)),
                      height: 80,
                      child: const Center(
                          child: ListTile(
                              leading: Icon(Icons.alarm),
                              title: Text('My Family Tree'))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(25)),
                      height: 80,
                      child: Center(
                          child: IconButton(
                        icon: const Icon(
                          Icons.message,
                          size: 30,
                        ),
                        onPressed: () {},
                      )),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Events at your place',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 400,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                                height: 200,
                                width: 200,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 1.0),
                                        child: Text(
                                          'Event ${index + 1}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 1.0),
                                        child: Text(
                                          'Subtitle of event ${index + 1}',
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer()
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 13);
                    },
                    itemCount: 5),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Donate Now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 15),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: donateItems.length,
                          itemBuilder: (context, index) {
                            return Container(child: donateItems[index]);
                          },
                        ),
                        Center(
                          child: Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.arrow_back_ios_new_sharp),
                                color: Colors.white,
                                onPressed: () {
                                  _goToPreviousPage();
                                },
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  _goToNextPage();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // ),
                  )),
              const SizedBox(height: 25),
              const Text(
                'Reports',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/race.jpeg',
                                )),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Event Expenses Report',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/donationImage.jpg',
                                )),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Donation Report',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/race.jpeg',
                                )),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Event Expenses Report',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3,
              //   width: MediaQuery.of(context).size.width,
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: GestureDetector(
              //         onTap: () {},
              //         child: Container(
              //           height: double.infinity,
              //           decoration: BoxDecoration(
              //               image: const DecorationImage(
              //                   fit: BoxFit.cover,
              //                   image: AssetImage(
              //                     'assets/images/race.jpeg',
              //                   )),
              //               color: const Color(0xFFF88906),
              //               borderRadius: BorderRadius.circular(15)),
              //           child: const Align(
              //             alignment: Alignment.bottomCenter,
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 'Event Expenses Report',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         ),
              //       )),
              //       const SizedBox(
              //         width: 12,
              //       ),
              //       Expanded(
              //           child: GestureDetector(
              //         onTap: () {},
              //         child: Container(
              //           height: double.infinity,
              //           decoration: BoxDecoration(
              //               image: const DecorationImage(
              //                   fit: BoxFit.cover,
              //                   image: AssetImage(
              //                     'assets/images/donationImage.jpg',
              //                   )),
              //               color: const Color(0xFFF88906),
              //               borderRadius: BorderRadius.circular(15)),
              //           child: const Align(
              //             alignment: Alignment.bottomCenter,
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 'Donation Report',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         ),
              //       )),
              //       const SizedBox(
              //         width: 12,
              //       ),
              //       Expanded(
              //           child: GestureDetector(
              //         onTap: () {},
              //         child: Container(
              //           height: double.infinity,
              //           decoration: BoxDecoration(
              //               image: const DecorationImage(
              //                   fit: BoxFit.cover,
              //                   image: AssetImage(
              //                     'assets/images/race.jpeg',
              //                   )),
              //               color: const Color(0xFFF88906),
              //               borderRadius: BorderRadius.circular(15)),
              //           child: const Align(
              //             alignment: Alignment.bottomCenter,
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 'Event Expenses Report',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         ),
              //       )),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
