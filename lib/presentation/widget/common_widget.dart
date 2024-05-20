import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/app_style.dart';

RichText buildAppLogo(BuildContext context) {
  return RichText(
      text: TextSpan(
          text: 'Ocean',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: AppColor.primaryColor, fontWeight: FontWeight.w900),
          children: [
        TextSpan(
            text: 'Talk',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColor.secondaryColor, fontWeight: FontWeight.w900))
      ]));
}

ElevatedButton buildElevatedButtonFill(
    BuildContext context, String text, Function() onPressed,Color color) {
  return ElevatedButton(
    onPressed: onPressed,
    style: AppStyle.buildElevatedButtonFillStyle(
        color),
    child: Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}
