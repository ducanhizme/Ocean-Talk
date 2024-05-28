import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/presentation/constants/app_pages.dart';

import '../../bloc/app/app_bloc.dart';
import '../constants/app_color.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: SizedBox(
              height: ScreenUtil().screenHeight *0.09,
              child: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: state.index,
                indicatorColor: AppColor.secondaryColor,
                onDestinationSelected: (index) {
                  context.read<AppBloc>().add(TriggerAppEvent(index));
                },
                elevation: 1,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Ionicons.home_outline,size: 20,),
                    label: 'Home',
                    selectedIcon:Icon(Ionicons.home_sharp,color: Colors.white,size: 20,),
                  ),
                  NavigationDestination(
                    icon: Icon(Ionicons.person_add_outline,size: 20,),
                    label: 'Search',
                    selectedIcon:Icon(Ionicons.person_add_sharp,color: Colors.white,size: 20,),
                  ),
                  NavigationDestination(
                    icon: Icon(Ionicons.settings_outline,size: 20,),
                    label: 'Profile',
                    selectedIcon:Icon(Ionicons.settings_sharp,color: Colors.white,size: 20,),
                  ),
                ],
              ),
            ),
            body: bttmNavPages[state.index]
        );
      },
    );
  }
}
