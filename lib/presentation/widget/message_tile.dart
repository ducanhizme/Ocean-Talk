import 'package:flutter/material.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import '../model/message_data.dart';

class MessageTile extends StatelessWidget {
  final MessageData messageData;
  const MessageTile({Key? key, required this.messageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColor.primaryColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(messageData.profilePicture),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      messageData.senderName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.senderName,
                      ),
                    ),
                    Text(
                      messageData.message,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColor.messages,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${messageData.messageDate.hour}:${messageData.messageDate.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    color: AppColor.messages,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
