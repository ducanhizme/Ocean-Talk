import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';

import '../presentation/constants/app_color.dart';
import '../presentation/constants/app_string.dart';
import '../presentation/constants/app_style.dart';


RichText buildAppLogo(BuildContext context) {
  return RichText(
      text: TextSpan(
          text: 'Ocean',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: AppColor.primaryColor, fontWeight: FontWeight.w900),
          children: [
        TextSpan(
            text: 'Talk',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColor.secondaryColor, fontWeight: FontWeight.w900))
      ]));
}

ElevatedButton buildElevatedButtonFill(
    BuildContext context, String text, Function() onPressed,Color color) {
  return ElevatedButton(
    onPressed: onPressed,
    style: AppStyle.buildElevatedButtonFillStyle(
        color),
    child: Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}


buildSocialButton(BuildContext context,String text, String sourceIcon, Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black, width: 1.w),
          borderRadius: BorderRadius.circular(5.w),
        ),
        child: Row(
          children: [
            Image.asset(sourceIcon,width: 20.w,height: 20.h,),
            Gap(5.w),
            Text(text,style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w500,color: Colors.black),),
          ],
        )
    ),
  );
}

buildOrLoginWithIndicator(BuildContext context) {
  return SizedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            indent: 15.w,
            endIndent: 5.w,
          ),
        ),
        Gap(10.w),
        Text(AppString.orLoginWith,style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w500,color: Colors.black),),
        Gap(10.w),
        Expanded(
          child: Divider(
            endIndent: 15.w,
            indent: 5.w,
          ),
        ),
      ],
    ),
  );
}

InkWell buildIconButton(Function() onPressed, IconData icon) {
  return InkWell(
    onTap: onPressed,
    child: Container(
        decoration: BoxDecoration(
          color:AppColor.bgIconButton,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Padding(
          padding:  EdgeInsets.all(5.w),
          child: Icon(icon),
        )
    ),
  );

}
BoxDecoration buildAppLinear() {
  return const BoxDecoration(
      color: Colors.blue,
      gradient:  LinearGradient(
        colors: [Color(0xff771f98), Color(0xffd9ad4c)],
        stops: [0.25, 0.75],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )
  );
}
