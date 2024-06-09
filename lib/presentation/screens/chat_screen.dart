import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
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
    return  BlocConsumer<ChatBloc, ChatState>(
  listener: (context, state) {
    if(state.messageStatus == MessageStatus.failed){
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
    if (state.messageStatus == MessageStatus.sent) {
      _scrollWhenUpdate();
    }
    if(state.listMessageStatus== ListMessageStatus.updated){
      _scrollWhenUpdate();
    }
  },
  builder: (context, state) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: _buildTitleChat(context,widget.user),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        physics: const BouncingScrollPhysics(),
        itemCount: state.messages.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          Message message = state.messages[index];
          return message.senderId == widget.user.uid ? _buildTextMessageReceive(message,context) : _buildTextMessageSend(message,context);
      },
      ),
      bottomNavigationBar: _buildSendMessageField(context),
    );
  },
);
  }

  Padding _buildSendMessageField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Gap(10.w),
            const Icon(Icons.camera_alt,color: AppColor.secondaryColor),
            Gap(10.w),
            const Icon(Icons.image,color: AppColor.secondaryColor),
            Gap(10.w),
            const Icon(Icons.mic,color: AppColor.secondaryColor),
            Gap(10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.secondaryColor),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 5.w),
                  child: TextField(
                    onChanged: (value) {
                      context.read<ChatBloc>().add(TextMessageChanged(value));
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Aa',
                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColor.secondaryColor),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send,color: AppColor.secondaryColor),
              onPressed: () {
                context.read<ChatBloc>().add(SendMessage(List.of([widget.user.uid])));
              },
            ),
          ],
        ),

      ),
    );
  }

  void _scrollWhenUpdate() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 50),
      curve: Curves.linear,
    );
  }

  _buildTitleChat(BuildContext context,AppUser user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: user.displayImage.isEmpty ? const AssetImage('assets/img/default_avatar.jpg'): Image.network(user.displayImage).image,
        ),
        Gap(10.w),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
             Text(user.fullName, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black)),
          ],
        ),
      ],
    );
  }
}

_buildTextMessageSend(Message message,BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenUtil().screenWidth * 0.67),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              message.content,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
              softWrap: true,
            ),
          ),
        ),
      ],
    ),
  );
}

_buildTextMessageReceive(Message message,BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenUtil().screenWidth * 0.67),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              border:Border.all(color: AppColor.primaryColor),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              message.content,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
              softWrap: true,
            ),
          ),
        ),
      ],
    ),
  );
}
