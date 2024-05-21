import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/app_style.dart';

class AuthenticationPickerField extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final String label;

  const AuthenticationPickerField(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Text(label,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w400, color: Colors.black)),
          Gap(8.h),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.w),
          borderRadius: BorderRadius.circular(5.w),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(child: InkWell(onTap: onTap, child: Icon(icon, size: 20.w))),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      readOnly: true,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
