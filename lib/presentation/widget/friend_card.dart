import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';

import '../../data/models/app_user.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    super.key,
    required this.friend,
  });

  final AppUser friend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom :10.w),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: CircleAvatar(
                          backgroundImage: friend
                              .displayImage
                              .isEmpty
                              ? Image.asset('assets/img/default_avatar.jpg')
                              .image
                              : Image.network(friend.displayImage)
                              .image,
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              friend.fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              friend.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                    },
                    child: Icon(Ionicons.chatbox_ellipses_outline,size: 20.w,)
                ),
                Gap(10.w),
                InkWell(
                    onTap: () {
                    },
                    child: Icon(Ionicons.ellipsis_horizontal_outline,size: 20.w,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}