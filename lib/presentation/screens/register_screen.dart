import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/app_color.dart';
import '../constants/app_string.dart';
import '../widget/authentication_field.dart';
import '../widget/authentication_picker_field.dart';
import '../widget/common_widget.dart';
import '../widget/remember_me.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2.w)),
                child: const Icon(Icons.arrow_back)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.headlineRegister,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    AppString.bodyRegister,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${AppString.orLoginWith}:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildSocialButton(
                          context, 'Google', 'assets/icon/google.png', () {}),
                      buildSocialButton(
                          context, 'Github', 'assets/icon/github.png', () {}),
                      buildSocialButton(
                          context, 'Facebook', 'assets/icon/facebook.png', () {}),
                    ],
                  ),
                  const AuthenticationField(
                      label: AppString.fullNameField, obscureText: false),
                  Gap(10.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AuthenticationPickerField(icon: Ionicons.calendar_sharp,label: AppString.dateOfBirthField,onTap: (){},),
                      ),
                      Gap(5.w),
                      Expanded(
                        flex: 1,
                        child: AuthenticationPickerField(icon: Ionicons.male_female_sharp,label: AppString.genderField,onTap: (){},),
                      ),
                    ],
                  ),
                  const AuthenticationField(
                      label: AppString.emailLabelField, obscureText: false),
                  const AuthenticationField(
                      label: AppString.passwordLabelField, obscureText: true),
                  const AuthenticationField(label: AppString.passwordConfirmField,obscureText: true,),
                  Gap(20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: buildElevatedButtonFill(context, AppString.buttonLogin,
                        () {}, AppColor.primaryColor),
                  ),
                  Gap(15.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: buildElevatedButtonFill(
                        context, AppString.buttonRegister, () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const RegisterScreen()));
                    }, AppColor.secondaryColor),
                  ),
                  Gap(25.h),
                ],
              ),
            ),
          ),
        ));
  }
}
