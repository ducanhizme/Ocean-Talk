
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/constants/app_icon.dart';
import 'package:ocean_talk/presentation/constants/app_string.dart';

class CustomAppBar extends StatelessWidget {
  final TabController tabController;

  const CustomAppBar({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: TabBar(
        controller: tabController,
        indicatorColor: AppColor.textFieldColor,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        tabs: const [
          Tab(text: AppString.tabName1),
          Tab(text: AppString.tabName2),
          Tab(text: AppString.tabName3),
        ],
      ),
      actions: [
        Container(
            height: 39,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: AppColor.textFieldColor,
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(AppIcon.searchIcon)),
        const SizedBox(width: 10),
        Container(
            height: 39,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: AppColor.textFieldColor,
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(AppIcon.scanIcon)),
      ],
    );
  }
}
