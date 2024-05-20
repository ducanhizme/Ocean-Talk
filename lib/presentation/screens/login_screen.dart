import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ocean_talk/presentation/constants/app_string.dart';
import 'package:ocean_talk/presentation/constants/app_style.dart';

import '../constants/app_color.dart';
import '../widget/authentication_field.dart';
import '../widget/common_widget.dart';
import '../widget/remember_me.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
              padding:  EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color:Colors.black, width: 2.w)
              ),
              child: const Icon(Icons.arrow_back)
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: buildAppLogo(context),
            ),
            Gap(20.h),
            Text(AppString.headlineLogin,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(AppString.bodyLogin,style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),),
            Gap(15.h),
            const AuthenticationField(label: AppString.emailLabelField,obscureText: false),
            Gap(10.h),
            const AuthenticationField(label: AppString.passwordLabelField,obscureText: true),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RememberMe(),
                InkWell(
                  onTap: (){},
                  child: Text(AppString.forgotPassword,style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w400,color: Colors.black),),
                ),
              ],
            ),
            Gap(20.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: buildElevatedButtonFill(context, AppString.buttonLogin, (){}, AppColor.primaryColor),
            ),
            Gap(15.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: buildElevatedButtonFill(context, AppString.buttonRegister, (){}, AppColor.secondaryColor),
            ),
            Gap(25.h),
            buildOrLoginWithIndicator(context),
            Gap(25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildSocialButton(context,'Google','assets/icon/google.png', (){}),
                buildSocialButton(context,'Github','assets/icon/github.png', (){}),
                buildSocialButton(context,'Facebook','assets/icon/facebook.png', (){}),
              ],
            )
          ],
        ),
      )
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




}

buildOrLoginWithIndicator(BuildContext context) {
  return SizedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            indent: 30.w,
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
            endIndent: 30.w,
            indent: 5.w,
          ),
        ),
      ],
    ),
  );
}


