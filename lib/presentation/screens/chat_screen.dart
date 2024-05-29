import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ocean_talk/presentation/constants/app_icon.dart';

import '../constants/app_color.dart';
import '../constants/app_string.dart';
import '../model/message_data.dart';

class ChatScreen extends StatefulWidget {
  final MessageData messageData;
  ChatScreen({super.key, required this.messageData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 5,
        toolbarHeight: 85,
        shadowColor: Colors.black,
        title: Row(
          children: [
            Image.asset(widget.messageData.profilePicture),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.messageData.senderName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.senderName,
                  ),
                ),
                Text(
                  widget.messageData.activeStatus ?? "",
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text("Test"),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppIcon.cameraIcon),
                    const SizedBox(width: 15),
                    SvgPicture.asset(AppIcon.imageIcon),
                    const SizedBox(width: 15),
                    SvgPicture.asset(AppIcon.microIcon),
                    const SizedBox(width: 15),
                  ],
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.secondaryColor,
                      hintText: AppString.hintTextChatScreen,
                      hintStyle: const TextStyle(color: AppColor.white, fontSize: 20),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(AppIcon.smileIcon),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
