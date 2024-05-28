import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/common/common_function.dart';

import '../constants/app_style.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 3 || newValue.text.length == 6) {
      if (newValue.text.substring(newValue.text.length - 1) != '/') {
        return TextEditingValue(
          text: '${newValue.text.substring(0, newValue.text.length - 1)}/${newValue.text.substring(newValue.text.length - 1)}',
          selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
        );
      }
    }
    return newValue;
  }
}

class AppDatePickerField extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const AppDatePickerField(
      {super.key,
      required this.icon,
      required this.label, required this.onChanged, this.validator});

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
                  Expanded(child: Icon(icon, size: 20.w)),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      validator: validator,
                      onChanged: onChanged,
                      inputFormatters: [DateInputFormatter()],
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