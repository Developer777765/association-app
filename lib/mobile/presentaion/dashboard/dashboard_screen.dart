// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/signUpUser.dart';
import 'package:temple_app/utils/preference.dart';
import '../../../common_widget/apptheme.dart';
import '../../../data/repository/get_register_repository.dart';
import '../../../utils/size_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

import '../login/login_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // var userProvider = ref.watch(profileProvider);
    String? userName = Preference.shared.getString(Preference.USER_NAME);
    // var ss = ref.watch(userProfileProvider)!.result[0].;

    double sizeHeight = TSizeUtils.hPercent(100, context: context);
    double sizeWidth = TSizeUtils.wPercent(100, context: context);

    final List<String> images = [
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjAFGJbrnvpuS9CSlO5NOnWvExa9JCHpkGCaVlyLD_sCdNQcYHEO9TM_rIdiklOpMVXeAVooydB3p79RbZ1MlR99Idonj5Jv55_gSHaF2BB9LtkiHnlHeT2BV9_6s0GzPeH5bfShjEnUpbO/s640/How-to-use-Slick-Slider-for-your-website.jpg',
      'https://enweb.vn/wp-content/uploads/2021/09/slider-website.png'
    ];

    final List<Map<String, String>> items = [
      {"icon": "🍲", "label": "Annadhaanam"},
      {"icon": "🫗", "label": "Baalaabishegam"},
      {"icon": "🏺", "label": "Pongal Urchavam"},
      {"icon": "🥁", "label": "Naathaswaram - Melam"},
      {"icon": "💃", "label": "Karakottam"},
      {"icon": "💦", "label": "Manjal Neeraattu"},
      {"icon": "🏋️‍♂️", "label": "Vilayaatu Pottigal"},
      {"icon": "🕯️", "label": "Kuththu Vilakku Poojai"},
      {"icon": "💸", "label": "Kaanikkai"},
      {"icon": "💰", "label": "Thalai Kattu Vari"}
    ];
    Future<void> logout() async {
      // try {
      //   var personBox = Hive.box<UserProfile>('userProfileBox');
      //   await personBox.clear();
      //   ref.read(userProfileProvider.notifier).update((state) => null);
      //   SharedPreferences preferences = await SharedPreferences.getInstance();
      //   await preferences.clear();
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => LoginScreen(),
      //       ));
      // } catch (ex) {
      //   debugPrint('something went wrong with fetching Hive data: $ex');
      // }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF003366),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primayColor,
                Color.fromARGB(255, 65, 102, 133),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Header Container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primayColor,
                  Color.fromARGB(255, 65, 102, 133),
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Hello! $userName",
                      style: TextStyle(
                        color: Color(0xFFF88906),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // GestureDetector(
                //   onTap: () {
                //     logout();
                //   },
                //   child: Icon(
                //     Icons.power_settings_new,
                //     color: Colors.white,
                //   ),
                // )
                // CircleAvatar(
                //   radius: 20,
                //   backgroundImage: NetworkImage(
                //     'https://img.freepik.com/premium-vector/avatar-icon-circle-male-sign-vector-illustration_276184-170.jpg?w=740',
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CarouselSlider(
                    items: images.map((imgUrl) {
                      return Container(
                        height: 100,
                        width: sizeWidth,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: sizeHeight,
                                  width: double.infinity,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Image.network(
                                imgUrl,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 160,
                      aspectRatio: 5.0,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 0.88,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      autoPlayInterval:
                          Duration(seconds: 5), // Adjust to a longer duration
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.deepblueColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['icon'] ?? '',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    item['label'] ?? '',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
