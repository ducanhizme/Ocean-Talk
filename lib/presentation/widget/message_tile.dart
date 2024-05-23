import 'package:flutter/material.dart';
import 'package:ocean_talk/presentation/constants/app_color.dart';
import 'package:ocean_talk/presentation/constants/app_icon.dart';

class MessageTile extends StatelessWidget {
  //final MessageData messageData;
  const MessageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.primaryColor, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(AppIcon.avatar),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Robert Fox",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.senderName),
                    ),
                    Text(
                      "Hey, let's play basketball",
                      style: TextStyle(fontSize: 13, color: AppColor.messages),
                    ),
                  ],
                ),
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "15:43",
                  style: TextStyle(color: AppColor.messages, fontSize: 11),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
