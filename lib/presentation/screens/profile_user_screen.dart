import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/bloc/profile_user_screen/profile_user_bloc.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/widget/friend_card_vertical.dart';
import '../../common/common_widget.dart';
import '../../data/models/app_user.dart';

class ProfileUserScreen extends StatefulWidget {
  final AppUser user;

  const ProfileUserScreen({super.key, required this.user});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileUserBloc>().add(FetchProfileUser(widget.user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: BlocConsumer<ProfileUserBloc, ProfileUserState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state.status == ProfileUserStatus.loading) {
              return const Center(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state.status == ProfileUserStatus.failure) {
              return const Center(
                child: Text('Error'),
              );
            } else if (state.status == ProfileUserStatus.success) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScreenUtil().screenHeight * 0.25 + 75.h,
                    child: Stack(
                      children: [
                        Container(
                          height: ScreenUtil().screenHeight * 0.25,
                          width: double.infinity,
                          decoration: buildAppLinear(),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 20.w,
                          child: Container(
                            width: 150.w,
                            height: 150.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: CircleAvatar(
                                backgroundImage:
                                    widget.user.displayImage.isEmpty
                                        ? Image.asset(
                                            'assets/img/default_avatar.jpg',
                                          ).image
                                        : Image.network(
                                            widget.user.displayImage,
                                          ).image,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                            icon: const Icon(
                              Ionicons.arrow_back_circle_outline, size: 40,
                              color: Colors
                                  .white, // Change this to a color that contrasts with your background
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        // buildElevatedButtonFill(context, text, () => null, color)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.user.email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  widget.user.gender,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date of Birth',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  widget.user.dateOfBirth,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(10.h),
                        SizedBox(
                          width: double.infinity,
                          child: _buildToggleRequestFriend(state),
                        ),
                        Gap(10.h),
                        Text(
                          'Friends:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Gap(10.h),
                        SizedBox(
                            width: double.infinity,
                            height: ScreenUtil().screenHeight * 0.4,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 120.w,
                                childAspectRatio: 2 / 3.1,
                                crossAxisSpacing: 5.w,
                                mainAxisSpacing: 10.h,
                              ),
                              shrinkWrap: true,
                              itemCount: widget.user.friends.length,
                              itemBuilder: (context, index) => FriendCardVertical(
                                friend: widget.user.friends[index],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Something went wrong!'));
          },
        ),
      ),
    ));
  }

  Widget _buildToggleRequestFriend(ProfileUserState state) {
    String buttonText;
    VoidCallback buttonAction;
    Color buttonColor = AppColor.primaryColor;

    if (state.userType == UserType.friend) {
      buttonText = 'Friend';
      buttonAction = () {};
    } else if (state.userType == UserType.stranger) {
      switch (state.requestStatus) {
        case RequestStatus.done:
          buttonText = 'Add Friend';
          buttonAction = () => context
              .read<ProfileUserBloc>()
              .add(AddRequestFriendEvent(widget.user));
          break;
        case RequestStatus.pending:
          buttonText = 'Cancel Request';
          buttonAction = () => context
              .read<ProfileUserBloc>()
              .add(RemoveRequestFriendEvent(widget.user));
          break;
        case RequestStatus.receive:
          return _buildFriendChoiceButton(state);
          break;
        default:
          buttonText = 'Add Friend';
          buttonAction = () => context
              .read<ProfileUserBloc>()
              .add(AddRequestFriendEvent(widget.user));
          break;
      }
    } else {
      buttonText = 'Add Friend';
      buttonAction = () {};
    }

    return buildElevatedButtonFill(
        context, buttonText, buttonAction, buttonColor);
  }

  Widget _buildFriendChoiceButton(ProfileUserState state) {
    return SizedBox(
      width: double.infinity,
      child: state.requestStatus == RequestStatus.loading ? const Center(child: CircularProgressIndicator(),):Row(
        children: [
          Expanded(
            child: buildElevatedButtonFill(
                context, 'Accept', () => context.read<ProfileUserBloc>().add(AcceptRequestFriendEvent(widget.user)), AppColor.primaryColor),
          ),
          Gap(10.w),
          Expanded(
            child: buildElevatedButtonFill(
                context, 'Reject', () => null, AppColor.secondaryColor),
          ),
        ],
      ),
    );
  }
}
