import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_color.dart';

class CustomIconTabbar extends StatelessWidget {
  String assetPath;
  bool isSelected;
  CustomIconTabbar({
    Key? key,
    required this.assetPath,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 32,
      decoration: BoxDecoration(
        color: isSelected ? AppColor.secondaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Center(
        child: SvgPicture.asset(assetPath,
            colorFilter: ColorFilter.mode(
                isSelected ? AppColor.white : AppColor.primaryColor,
                BlendMode.srcIn)),
      ),
    );
  }
}
