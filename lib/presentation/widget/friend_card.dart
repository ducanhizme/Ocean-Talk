import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../data/models/app_user.dart';
import '../screens/profile_user_screen.dart';

class FriendCard extends StatelessWidget {
  final AppUser friend;
  const FriendCard({
    super.key, required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProfileUserScreen(user: friend)),),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(
                    0, 1), // changes position of shadow
              ),
            ],
          ),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w)),
                    child: friend
                        .displayImage.isEmpty
                        ? Image.asset(
                        'assets/img/default_avatar.jpg',fit: BoxFit.fill
                    )
                        : Image.network(
                        friend
                            .displayImage,
                        fit: BoxFit.fill),
                  ),
                ),
                Gap(5.h),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    friend.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
