import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/common/common_function.dart';
import 'package:ocean_talk/common/validate/validator.dart';
import 'package:ocean_talk/presentation/widget/social_authentication.dart';
import 'package:page_transition/page_transition.dart';
import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_event.dart';
import '../../bloc/register/register_state.dart';
import '../../common/common_widget.dart';
import '../constants/app_color.dart';
import '../constants/app_string.dart';
import '../widget/app_field.dart';
import '../widget/app_date_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget with Validator {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

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
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.success) {
              context.read<RegisterBloc>().add(const RegisterReset());
              showToast(
                'Registration success',
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
                        child: const LoginScreen()));
              });
            } else if (state.status == RegisterStatus.failure) {
              context.read<RegisterBloc>().add( const RegisterReset());
              showToast(
                'Registration failed! Please try again',
                context: context,
                position: StyledToastPosition.top,
                backgroundColor: Colors.red,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.headlineRegister,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        AppString.bodyRegister,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${AppString.orLoginWith}:',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Gap(10.h),
                      const SocialAuthentication(),
                      Form(
                          key: _formKey,
                          autovalidateMode: state.autovalidateMode,
                          child: Column(
                            children: [
                              AppField(
                                  onChanged: (value) =>
                                      context
                                          .read<RegisterBloc>()
                                          .add(RegisterFullNameChanged(value)),
                                  validator: validateUsername,
                                  label: AppString.fullNameField,
                                  obscureText: false),
                              Gap(10.h),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AppDateField(
                                      onChanged: (value) =>
                                          context
                                              .read<RegisterBloc>()
                                              .add(RegisterDateOfBirthChanged(value)),
                                      validator: validateDateOfBirth,
                                      icon: Ionicons.calendar_sharp,
                                      label: AppString.dateOfBirthField,
                                    ),
                                  ),
                                  Gap(5.w),
                                  Expanded(
                                    flex: 1,
                                    child: AppDateField(
                                      icon: Ionicons.male_female_sharp,
                                      label: AppString.genderField, onChanged: ( value) {  },
                                    ),
                                  ),
                                ],
                              ),
                              AppField(
                                  validator: validateEmail,
                                  onChanged: (value) =>
                                      context
                                          .read<RegisterBloc>()
                                          .add(RegisterEmailChanged(value)),
                                  label: AppString.emailLabelField,
                                  obscureText: false),
                              AppField(
                                  validator: validatePassword,
                                  onChanged: (value) =>
                                      context
                                          .read<RegisterBloc>()
                                          .add(RegisterPasswordChanged(value)),
                                  label: AppString.passwordLabelField,
                                  obscureText: true),
                              AppField(
                                validator:
                                validateConfirmPassword(state.password),
                                onChanged: (value) =>
                                    context
                                        .read<RegisterBloc>()
                                        .add(
                                        RegisterConfirmPasswordChanged(value)),
                                label: AppString.passwordConfirmField,
                                obscureText: true,
                              ),
                            ],
                          )),
                      Gap(20.h),
                      Gap(15.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: buildElevatedButtonFill(
                            context, AppString.buttonRegister, () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterBloc>().add(
                                RegisterSubmitted(state.email, state.password));
                          } else {
                            context.read<RegisterBloc>().add(
                                const RegisterAutovalidateModeChanged(
                                    AutovalidateMode.always));
                          }
                        }, AppColor.secondaryColor),
                      ),
                      Gap(25.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
