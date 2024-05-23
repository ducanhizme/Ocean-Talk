import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/constants/app_icon.dart';
import 'package:ocean_talk/presentation/constants/app_string.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const CustomAppBar({super.key, required this.tabController});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 39,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  cursorColor: AppColor.hintTextColor,
                  decoration: InputDecoration(
                    hintText: AppString.hintTextSearch,
                    filled: true,
                    fillColor: AppColor.textFieldColor,
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: SvgPicture.asset(AppIcon.searchIcon,
                        fit: BoxFit.scaleDown),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 15),
              height: 39,
              width: 43,
              decoration: BoxDecoration(
                color: AppColor.textFieldColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: SvgPicture.asset(AppIcon.scanIcon)),
            ),
          ],
        ),
      ),
      bottom: TabBar(
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
    );
  }
}
