import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ocean_talk/presentation/constants/app_string.dart';
import 'package:ocean_talk/presentation/pages/friend_page.dart';
import 'package:ocean_talk/presentation/pages/messages_page.dart';
import 'package:ocean_talk/presentation/pages/setting_page.dart';
import '../constants/app_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = const [MessagesPage(), FriendPage(), SettingPage()];

  final _indexController = BehaviorSubject<int>.seeded(0);

  @override
  void dispose() {
    _indexController.close();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _indexController.add(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: _indexController.stream,
        initialData: 0,
        builder: (context, snapshot) {
          final selectedIndex = snapshot.data ?? 0;
          return pages.elementAt(selectedIndex);
        },
      ),
      bottomNavigationBar: StreamBuilder<int>(
        stream: _indexController.stream,
        initialData: 0,
        builder: (context, snapshot) {
          final selectedIndex = snapshot.data ?? 0;
          return BottomNavigationBar(
            currentIndex: selectedIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(AppIcon.homeIcon),
                label: AppString.bottomNavbarLabel1,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcon.personAddIcon,
                ),
                label: AppString.bottomNavbarLabel2,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcon.settingIcon,
                ),
                label: AppString.bottomNavbarLabel3,
              ),
            ],
          );
        },
      ),
    );
  }
}
