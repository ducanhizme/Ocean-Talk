import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../constants/app_style.dart';

class AuthenticationField extends StatelessWidget {
  final String label;
  final bool obscureText;
  const AuthenticationField({
    super.key, required this.label, required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w400,color: Colors.black),),
        Gap(8.h),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w500,color: Colors.black),
            obscureText: obscureText,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(10.h),
              border: AppStyle.buildOutlineInputBorder(),
              focusedBorder: AppStyle.buildOutlineInputBorder(),
              disabledBorder: AppStyle.buildOutlineInputBorder(),
              enabledBorder: AppStyle.buildOutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}