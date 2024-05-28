import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastGlobalCustomize extends StatelessWidget {
  final Widget child;
  const ToastGlobalCustomize({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      locale: const Locale('en', 'US'),  //You have to set this parameters to your locale
      textStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w500,color:Colors.white), //Default text style of toast
      backgroundColor: const Color(0x99000000),  //Background color of toast
      borderRadius: BorderRadius.circular(5.0), //Border radius of toast
      textPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 10.h),//The padding of toast text
      toastPositions: StyledToastPosition.bottom, //The position of toast
      toastAnimation: StyledToastAnimation.fade,  //The animation type of toast
      reverseAnimation: StyledToastAnimation.fade, //The reverse animation of toast (display When dismiss toast)
      curve: Curves.fastOutSlowIn,  //The curve of animation
      reverseCurve: Curves.fastLinearToSlowEaseIn, //The curve of reverse animation
      duration: const Duration(milliseconds: 2000), //The duration of toast showing, when set [duration] to Duration.zero, toast won't dismiss automatically.
      animDuration: const Duration(milliseconds: 1000), //The duration of animation(including reverse) of toast
      dismissOtherOnShow: true,  //When we show a toast and other toast is showing, dismiss any other showing toast before.//When the window configuration changes, move the toast.
      fullWidth: false, //Whether the toast is full screen (subtract the horizontal margin)
      isHideKeyboard: true, //Is hide keyboard when toast show
      isIgnoring: true, //Is the input ignored for the toast
      animationBuilder: (BuildContext context, AnimationController controller, Duration duration, Widget child) {
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
          child: child,
        );
      },
      reverseAnimBuilder: (BuildContext context, AnimationController controller, Duration duration, Widget child) {
        return FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(controller),
          child: child,
        );
      },
      child: child,
    );
  }
}
