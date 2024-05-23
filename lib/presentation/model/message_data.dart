import 'package:ocean_talk/presentation/constants/app_icon.dart';

class MessageData {
  final String senderName;
  final String message;
  final DateTime messageDate;
  final String profilePicture;

  MessageData(
      {required this.senderName,
      required this.profilePicture,
      required this.messageDate,
      required this.message});
}

List<MessageData> listMessages = [
  MessageData(
      senderName: "Robert Fox",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Hey, let's play basketball"),
  MessageData(
      senderName: "Esther Howard",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Perfect, see you later"),
  MessageData(
      senderName: "Jacob Jones",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Oh you're right lmao"),
  MessageData(
      senderName: "Bessie Cooper",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Don't forget tonight"),
  MessageData(
      senderName: "Robert Fox",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Hey, let's play basketball"),
  MessageData(
      senderName: "Albert Flores",
      profilePicture: AppIcon.avatar,
      messageDate: DateTime.now(),
      message: "Bro wanna play basketball"),
];
