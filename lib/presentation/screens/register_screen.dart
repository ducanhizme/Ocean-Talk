import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/bloc/register_event.dart';
import 'package:ocean_talk/common/validate/validator.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc/register_bloc.dart';
import '../../bloc/register_state.dart';
import '../../common/common_widget.dart';
import '../constants/app_color.dart';
import '../constants/app_string.dart';
import '../widget/authentication_field.dart';
import '../widget/authentication_picker_field.dart';

class RegisterScreen extends StatelessWidget with Validator{
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
            if(state.status == RegisterStatus.success){
              context.read<RegisterBloc>().add(const RegisterReset());
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful, Please login')));
              Navigator.pushNamed(context, '/login');
            }else if(state.status == RegisterStatus.failure){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration failure, Email already in use')));
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
                          buildSocialButton(context, 'Google',
                              'assets/icon/google.png', () {}),
                          buildSocialButton(context, 'Github',
                              'assets/icon/github.png', () {}),
                          buildSocialButton(context, 'Facebook',
                              'assets/icon/facebook.png', () {}),
                        ],
                      ),
                      Form(
                          key: _formKey,
                          autovalidateMode: state.autovalidateMode,
                          child: Column(
                        children: [
                           AuthenticationField(
                             onChanged: (value) => context
                                 .read<RegisterBloc>()
                                 .add(RegisterFullNameChanged(value)),
                            validator: validateUsername,
                              label: AppString.fullNameField, obscureText: false
                          ),
                          Gap(10.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: AuthenticationPickerField(
                                  icon: Ionicons.calendar_sharp,
                                  label: AppString.dateOfBirthField,
                                  onTap: () {},
                                ),
                              ),
                              Gap(5.w),
                              Expanded(
                                flex: 1,
                                child: AuthenticationPickerField(
                                  icon: Ionicons.male_female_sharp,
                                  label: AppString.genderField,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                           AuthenticationField(
                             validator: validateEmail,
                              onChanged: (value) => context
                                 .read<RegisterBloc>()
                                 .add(RegisterEmailChanged(value)),

                              label: AppString.emailLabelField, obscureText: false),
                           AuthenticationField(
                             validator: validatePassword,
                              onChanged: (value) => context
                                 .read<RegisterBloc>()
                                 .add(RegisterPasswordChanged(value)),
                              label: AppString.passwordLabelField,
                              obscureText: true),
                           AuthenticationField(
                             validator: validateConfirmPassword(state.password),
                              onChanged: (value) => context
                                 .read<RegisterBloc>()
                                 .add(RegisterConfirmPasswordChanged(value)),
                            label: AppString.passwordConfirmField,
                            obscureText: true,
                          ),
                        ],
                      )),
                      Gap(20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: buildElevatedButtonFill(
                            context,
                            AppString.buttonLogin,
                                () {},
                            AppColor.primaryColor),
                      ),
                      Gap(15.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: buildElevatedButtonFill(
                            context, AppString.buttonRegister, () {
                              if(_formKey.currentState!.validate()){
                                context.read<RegisterBloc>().add(RegisterSubmitted(state.email,state.password));
                              }else{
                                context.read<RegisterBloc>().add(const RegisterAutovalidateModeChanged(AutovalidateMode.always));
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
