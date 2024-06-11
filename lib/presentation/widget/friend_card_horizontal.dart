import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/bloc/chat/chat_bloc.dart';
import 'package:ocean_talk/bloc/profile_user_screen/profile_user_bloc.dart';
import 'package:ocean_talk/data/repository/user_repository.dart';

import '../../data/models/app_user.dart';
import '../../data/repository/chat_repository.dart';
import '../screens/chat_screen.dart';
import '../screens/profile_user_screen.dart';

class FriendCardHorizontal extends StatelessWidget {
  const FriendCardHorizontal({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ProfileUserBloc(
                  RepositoryProvider.of<UserRepository>(context)),
              child: ProfileUserScreen(user: user),
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.w),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            backgroundImage: user.displayImage.isEmpty
                                ? Image.asset('assets/img/default_avatar.jpg')
                                .image
                                : Image.network(user.displayImage).image,
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                user.email,
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
                  Expanded(child:Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ChatBloc(
                                    RepositoryProvider.of<UserRepository>(context),
                                    chatRepository: RepositoryProvider.of<ChatRepository>(context),
                                  ),
                                  child: ChatScreen(user: user),
                                ),
                              ),
                            );
                          },
                          child: Icon(Ionicons.chatbox_ellipses_outline, size: 20.w)
                      ),
                      Gap(10.w),
                      Icon(Ionicons.ellipsis_horizontal_circle_outline, size: 20.w),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
