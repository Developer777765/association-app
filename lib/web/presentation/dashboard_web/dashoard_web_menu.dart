// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/web/presentation/login_web/login_screen_web.dart';
import '../../../common_widget/apptheme.dart';
import '../../../common_widget/responsive_widget.dart';
import '../../../data/repository/get_register_repository.dart';
import '../../../utils/preference.dart';
import 'dashboard_web.dart';

class DashoardWebMenu extends ConsumerStatefulWidget {
  const DashoardWebMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashoardWebMenuState();
}

class _DashoardWebMenuState extends ConsumerState<DashoardWebMenu> {
  String _selectedMenu = 'Dashboard';
  bool _showSidebar = true;

  final Map<String, Widget> _menuWidgets = {
    'Dashboard': const DashboardWeb(),
    'Logout': const LoginScreenWeb(),
    'About': const DashboardWeb(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: ResponsiveWidget(
        desktop: _showSidebar
            ? Row(
                children: [
                  _buildSidebar(),
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: _menuWidgets[_selectedMenu] ??
                          const SizedBox.shrink(),
                    ),
                  ),
                ],
              )
            : _menuWidgets[_selectedMenu] ?? const SizedBox.shrink(),
        mobile: const DashboardWeb(),
        tablet: const DashboardWeb(),
      ),
    );
  }

  Widget _buildSidebar() {
    String? userName = Preference.shared.getString(Preference.USER_NAME);

    return Container(
      width: 250,
      color: AppTheme.primayColor,
      child: Column(
        children: [
          Container(
            height: 100,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      userName.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.transparent),
          _buildMenuItem(Icons.home, 'Dashboard', onTap: () {
            setState(() {
              _selectedMenu = 'Dashboard';
              _showSidebar = true;
            });
          }),
          _buildMenuItem(Icons.logout, 'Logout', onTap: () {
            setState(() {
              _selectedMenu = 'Logout';
              _showSidebar = false;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,
      {required VoidCallback onTap}) {
    bool isSelected = _selectedMenu == title; // Check if the item is selected
    return Container(
      color: isSelected
          ? AppTheme.orangeColor
          : Colors.transparent, // Highlight selected
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.grey),
        title: Text(
          title,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey, fontSize: 12),
        ),
        onTap: onTap,
      ),
    );
  }
}
