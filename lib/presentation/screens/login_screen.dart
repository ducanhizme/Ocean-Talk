import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:ocean_talk/presentation/constants/app_string.dart';
import 'package:ocean_talk/presentation/screens/register_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../bloc/login/login_bloc.dart';
import '../../common/common_widget.dart';
import '../constants/app_color.dart';
import '../widget/app_field.dart';
import '../widget/remember_me.dart';
import '../widget/social_authentication.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2.w)
                ),
                child: const Icon(Icons.arrow_back)
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              context.read<LoginBloc>().add(const LoginReset());
              showToast(
                'Login success',
                context: context,
                position: StyledToastPosition.top,
                backgroundColor: AppColor.primaryColor,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.w)),
                ),
              );
              Future.delayed(const Duration(milliseconds: 2500), () {
                Navigator.pop(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child:  RegisterScreen()));
              });
            }else if (state.status == LoginStatus.failure ) {
              showToast(
                state.msg,
                context: context,
                position: StyledToastPosition.top,
                backgroundColor: AppColor.primaryColor,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.w)),
                ),
                onDismiss: (){
                  context.read<LoginBloc>().add(const LoginReset());
                }
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: buildAppLogo(context),
                    ),
                    Gap(20.h),
                    Text(AppString.headlineLogin,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(AppString.bodyLogin, style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),),
                    Gap(15.h),
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            AppField(
                              label: 'Email',
                              obscureText: false,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(LoginEmailChanged(value));
                              },
                            ),
                            Gap(10.h),
                            AppField(
                              label: 'Password',
                              obscureText: true,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(LoginPasswordChanged(value));
                              },
                            ),
                          ],
                        )
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RememberMe(),
                        InkWell(
                          onTap: () {},
                          child: Text(AppString.forgotPassword, style: Theme
                              .of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black),),
                        ),
                      ],
                    ),
                    Gap(20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: buildElevatedButtonFill(
                          context, AppString.buttonLogin, () {
                          context.read<LoginBloc>().add(LoginSubmitted(state.email, state.password));
                      },
                          AppColor.primaryColor),
                    ),
                    Gap(15.h),
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: buildElevatedButtonFill(
                          context, AppString.buttonRegister, () {
                        Navigator.push(context, PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: RegisterScreen()));
                      },
                          AppColor.secondaryColor),
                    ),
                    Gap(25.h),
                    buildOrLoginWithIndicator(context),
                    Gap(25.h),
                    const SocialAuthentication()
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}





