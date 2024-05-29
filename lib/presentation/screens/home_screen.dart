// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await FirebaseAuth.instance.signOut();
//           },
//           child: const Text('Back'),
//         ),
//
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/widget/custom_icon_tabbar.dart';
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
            selectedItemColor: AppColor.secondaryColor,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: CustomIconTabbar(
                  assetPath: AppIcon.homeIcon,
                  isSelected: selectedIndex == 0,
                ),
                label: AppString.bottomNavbarLabel1,
              ),
              BottomNavigationBarItem(
                icon: CustomIconTabbar(
                    assetPath: AppIcon.personAddIcon,
                    isSelected: selectedIndex == 1),
                label: AppString.bottomNavbarLabel2,
              ),
              BottomNavigationBarItem(
                icon: CustomIconTabbar(
                    assetPath: AppIcon.settingIcon,
                    isSelected: selectedIndex == 2),
                label: AppString.bottomNavbarLabel3,
              ),
            ],
          );
        },
      ),
    );
  }
}
