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
