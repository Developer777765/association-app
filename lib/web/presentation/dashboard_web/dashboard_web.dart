// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temple_app/common_widget/responsive_widget.dart';
import 'package:temple_app/mobile/presentaion/dashboard/dashboard_screen.dart';
import 'package:temple_app/web/presentation/login_web/login_screen_web.dart';
import '../../../common_widget/apptheme.dart';
import '../../../data/repository/dashboard_repository.dart';
import '../../../utils/preference.dart';
import '../../../utils/size_utils.dart';
import '../../router_web/route_enums_web.dart';

class DashboardWeb extends ConsumerStatefulWidget {
  const DashboardWeb({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardWebState();
}

class _DashboardWebState extends ConsumerState<DashboardWeb> {
  String _selectedMenu = 'Home'; // Track selected menu

  @override
  Widget build(BuildContext context) {
    double sizeHeight = TSizeUtils.hPercent(100, context: context);
    double sizeWidth = TSizeUtils.wPercent(100, context: context);
    String? userName = Preference.shared.getString(Preference.USER_NAME);

    final List<String> images = [
      "https://citiesandhotels.com/wp-content/uploads/2023/05/P1000944.JPGmurugantemple-blogimage-1.jpg"
          "https://citiesandhotels.com/wp-content/uploads/2023/05/P1000944.JPGmurugantemple-blogimage-1.jpg"
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
    return ref.watch(getDashboardProvider('')).when(
        data: (data) {
          return Scaffold(
            backgroundColor: AppTheme.whiteColor,
            appBar: MediaQuery.of(context).size.width < 700
                ? AppBar(
                    //mobile view
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.orangeColor,
                            ),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                    actions: [],
                    scrolledUnderElevation: 0,
                    backgroundColor: AppTheme.primayColor)
                : MediaQuery.of(context).size.width >= 700 &&
                        MediaQuery.of(context).size.width <= 1200
                    ? AppBar(
                        // tablet view
                        leading: Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              icon: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.orangeColor,
                                ),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          },
                        ),
                        backgroundColor: AppTheme.primayColor)
                    : AppBar(
                        //  web view
                        automaticallyImplyLeading: false,
                        backgroundColor: AppTheme.primayColor,
                      ),
            drawer: MediaQuery.of(context).size.width < 700
                ? Drawer(
                    backgroundColor: AppTheme.primayColor,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: AppTheme.primayColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150',
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                userName.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 40,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.orangeColor,
                            ),
                            child: Icon(
                              Icons.home,
                              size: 15,
                              color: AppTheme.whiteColor,
                            ),
                          ),
                          title: Text(
                            'Dashboard',
                            style: TextStyle(
                                color: AppTheme.whiteColor, fontSize: 12),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => DashboardWeb(),
                            //     ));
                            context.goNamed(Routes.dashboardWeb.name);
                          },
                        ),
                        ListTile(
                          leading: Container(
                            height: 40,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.orangeColor,
                            ),
                            child: Icon(
                              Icons.power_settings_new,
                              size: 15,
                              color: AppTheme.whiteColor,
                            ),
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                color: AppTheme.whiteColor, fontSize: 12),
                          ),
                          onTap: () {
                            context.pushNamed(Routes.loginWeb.name);
                          },
                        ),
                      ],
                    ),
                  )
                : MediaQuery.of(context).size.width >= 700 &&
                        MediaQuery.of(context).size.width <= 1200
                    ? Drawer(
                        backgroundColor: AppTheme.primayColor,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            DrawerHeader(
                              decoration: BoxDecoration(
                                color: AppTheme.primayColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      'https://via.placeholder.com/150',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    userName.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              leading: Container(
                                height: 40,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.orangeColor,
                                ),
                                child: Icon(
                                  Icons.home,
                                  size: 15,
                                  color: AppTheme.whiteColor,
                                ),
                              ),
                              title: Text(
                                'Dashboard',
                                style: TextStyle(
                                    color: AppTheme.whiteColor, fontSize: 12),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardWeb(),
                                    ));
                                // context.goNamed(Routes.dashboardWeb.name);
                              },
                            ),
                            ListTile(
                              leading: Container(
                                height: 40,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.orangeColor,
                                ),
                                child: Icon(
                                  Icons.power_settings_new,
                                  size: 15,
                                  color: AppTheme.whiteColor,
                                ),
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                    color: AppTheme.whiteColor, fontSize: 12),
                              ),
                              onTap: () {
                                context.goNamed(Routes.loginWeb.name);
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
            body: ResponsiveWidget(
                desktop: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            CarouselSlider(
                              items: images.map((imgUrl) {
                                return Container(
                                  height: 160,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300]!,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.network(
                                          imgUrl,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
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
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(Icons.error,
                                                  color: Colors.black),
                                            );
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
                                autoPlayInterval: Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 10),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  // web view
                                  crossAxisCount:
                                      4, // Increase this to reduce width
                                  crossAxisSpacing:
                                      4, // Reduce spacing for tighter layout
                                  mainAxisSpacing:
                                      8, // Reduce spacing for tighter layout
                                  childAspectRatio: 5 /
                                      3, // Adjust ratio for smaller height/width
                                ),
                                itemCount: data.result!.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.deepblueColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              item['icon'] ?? '',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              data.result![index].dbmasterName
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                mobile: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            CarouselSlider(
                              items: images.map((imgUrl) {
                                return Container(
                                  height: 160,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300]!,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.network(
                                          imgUrl,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
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
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(Icons.error,
                                                  color: Colors.red),
                                            );
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
                                autoPlayInterval: Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // mobile view
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              item['icon'] ?? '',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              item['label'] ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                    )
                  ],
                ),
                tablet: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            CarouselSlider(
                              items: images.map((imgUrl) {
                                return Container(
                                  height: 160,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300]!,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.network(
                                          imgUrl,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
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
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(Icons.error,
                                                  color: Colors.green),
                                            );
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
                                autoPlayInterval: Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 10),
                              child: GridView.builder(
                                shrinkWrap: true,
                                //tablet view
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      3, // Increase this to reduce width
                                  crossAxisSpacing:
                                      4, // Reduce spacing for tighter layout
                                  mainAxisSpacing:
                                      8, // Reduce spacing for tighter layout
                                  childAspectRatio: 8 /
                                      5, // Adjust ratio for smaller height/width
                                ),
                                itemCount: data.result!.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.deepblueColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              item['icon'] ?? '',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              data.result![index].dbmasterName
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                )),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error'));
        },
        loading: () => Scaffold(
              body: Shimmer.fromColors(
                baseColor: Colors.grey[100]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: sizeHeight,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ));
  }

  Widget _getSelectedWidget() {
    switch (_selectedMenu) {
      case 'Dashboard':
        return Container(
          height: 100,
          alignment: Alignment.center,
          child: const Text(
            'Logo',
            style: TextStyle(color: Colors.red, fontSize: 24),
          ),
        );
      case 'Settings':
        return const DashboardWeb();
      case 'About':
        return const DashboardWeb();
      default:
        return Container(
          height: 100,
          alignment: Alignment.center,
          child: const Text(
            'Logo',
            style: TextStyle(color: Colors.red, fontSize: 24),
          ),
        );
    }
  }

  Widget _buildMenuItem(IconData icon, String title,
      {required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
