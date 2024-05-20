import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/constants/app_string.dart';
import 'package:ocean_talk/presentation/constants/common.dart';
import 'package:ocean_talk/presentation/screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/app_style.dart';
import '../widget/common_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(AppString.headlineWelcome,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Gap(10.h),
                  Text(AppString.bodyWelcome,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Gap(30.h),
                  CarouselImages(
                    scaleFactor: 0.1,
                    listImages: listImagesWelcome,
                    height: ScreenUtil().screenHeight * 0.5,
                    borderRadius: 30.0,
                    cachedNetworkImage: true,
                    verticalAlignment: Alignment.topCenter,
                  ),
                  Gap(30.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: buildElevatedButtonFill(
                        context, AppString.buttonWelcome, () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const LoginScreen()));
                    }, AppColor.primaryColor),
                  )
                ]),
          ),
        )));
  }


}
