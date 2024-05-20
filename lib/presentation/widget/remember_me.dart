import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../constants/app_string.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(AppString.rememberMe,style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w400,color: Colors.black),),
        Gap(10.w),
        SizedBox(height:10.h,width:10.w,child: Transform.scale(scale:0.8,child: Checkbox(value: true, onChanged: (checked){}))),
      ],
    );
  }
}