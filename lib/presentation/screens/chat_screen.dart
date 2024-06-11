import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:images_picker/images_picker.dart';
import 'package:ocean_talk/bloc/chat/chat_bloc.dart';
import 'package:ocean_talk/data/models/app_user.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';

import '../../data/models/message.dart';

class ChatScreen extends StatefulWidget {
  final AppUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ChatBloc>().add(ChatStarted(widget.user.uid));
    super.initState();
  }

  @override
  void dispose() {
    context.read<ChatBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.messageStatus == MessageStatus.failed) {
          showToast(
            'Login success',
            context: context,
            position: StyledToastPosition.top,
            backgroundColor: Colors.red,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.w)),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: _buildTitleChat(context, widget.user),
          ),
          body: ListView.builder(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            itemCount: state.messages.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              Message message = state.messages[index];
              if (message.type == "text") {
                return message.senderId == widget.user.uid
                    ? _buildTextMessageReceive(message, context)
                    : _buildTextMessageSend(message, context);
              } else if (message.type == "image") {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: ScreenUtil().screenWidth * 0.67,
                            maxHeight:ScreenUtil().screenWidth * 0.67,
                        ),
                        child: Image.network(
                          message.content,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return message.senderId == widget.user.uid
                  ? _buildTextMessageReceive(message, context)
                  : _buildTextMessageSend(message, context);
            },
          ),
          bottomNavigationBar: _buildSendMessageField(context),
        );
      },
    );
  }

  Padding _buildSendMessageField(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Gap(10.w),
            _buildSendMediaMessages(
                Icons.camera_alt, AppColor.secondaryColor, () {}),
            Gap(10.w),
            _buildSendMediaMessages(Icons.image, AppColor.secondaryColor,
                () async {
              final images = await ImagesPicker.pick(
                count: 1,
                pickType: PickType.image,
                quality: 0.5,
                cropOpt: CropOption(
                  aspectRatio: const CropAspectRatio(1, 1),
                ),
              );
              chatBloc.add(TextMessageChanged(
                  images?[0].path == null ? "" : images![0].path));
              chatBloc.add(SendMessage(List.of([widget.user.uid]), "image"));
            }),
            Gap(10.w),
            _buildSendMediaMessages(Icons.mic, AppColor.secondaryColor, () {}),
            Gap(10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.secondaryColor),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: TextField(
                    onChanged: (value) {
                      context.read<ChatBloc>().add(TextMessageChanged(value));
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Aa',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColor.secondaryColor),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.messageStatus == MessageStatus.sending) {
                  return Padding(
                    padding: EdgeInsets.all(5.w),
                    child: SizedBox(
                        width: 30.w,
                        height: 30.h,
                        child: const CircularProgressIndicator(
                            color: AppColor.secondaryColor)),
                  );
                }
                if (state.messageStatus == MessageStatus.sent) {
                  return IconButton(
                    icon:
                        const Icon(Icons.send, color: AppColor.secondaryColor),
                    onPressed: () {
                      context
                          .read<ChatBloc>()
                          .add(SendMessage(List.of([widget.user.uid]), "text"));
                    },
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.send, color: AppColor.secondaryColor),
                  onPressed: () {
                    context
                        .read<ChatBloc>()
                        .add(SendMessage(List.of([widget.user.uid]), "text"));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildSendMediaMessages(IconData icon, Color color, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, color: color),
    );
  }

  _buildTitleChat(BuildContext context, AppUser user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: user.displayImage.isEmpty
              ? const AssetImage('assets/img/default_avatar.jpg')
              : Image.network(user.displayImage).image,
        ),
        Gap(10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.fullName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black)),
          ],
        ),
      ],
    );
  }
}

_buildTextMessageSend(Message message, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: ScreenUtil().screenWidth * 0.67),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              message.content,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
              softWrap: true,
            ),
          ),
        ),
      ],
    ),
  );
}

_buildTextMessageReceive(Message message, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: ScreenUtil().screenWidth * 0.67),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryColor),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              message.content,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
              softWrap: true,
            ),
          ),
        ),
      ],
    ),
  );
}
