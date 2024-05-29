import 'package:ocean_talk/presentation/constants/app_icon.dart';

class MessageData {
  final String senderName;
  final String? message;
  final DateTime? messageDate;
  final String profilePicture;
  final String? activeStatus;

  MessageData(
      {required this.senderName,
      required this.profilePicture,
      this.messageDate,
      this.message,
      this.activeStatus});
}

List<MessageData> listMessages = [
  MessageData(
      senderName: "Robert Fox",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Hey, let's play basketball",
      activeStatus: "online"),
  MessageData(
      senderName: "Esther Howard",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Perfect, see you later",
      activeStatus: "online"),
  MessageData(
      senderName: "Jacob Jones",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Oh you're right lmao",
      activeStatus: "online"),
  MessageData(
      senderName: "Bessie Cooper",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Don't forget tonight",
      activeStatus: "online"
  ),
  MessageData(
      senderName: "Robert Fox",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Hey, let's play basketball",
      activeStatus: "online"),
  MessageData(
      senderName: "Albert Flores",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Bro wanna play basketball",
      activeStatus: "offline"),
];
