part of 'chat_bloc.dart';

enum MessageStatus {none, sending, sent, failed }
enum ListMessageStatus{updated , none}
class ChatState {
  final String messageSendContent;
  final List<Message> messages;
  final MessageStatus messageStatus;
  final ListMessageStatus listMessageStatus;

  ChatState({
      this.messageSendContent="",
     this.messages =const [],
     this.messageStatus=MessageStatus.none,
    this.listMessageStatus=ListMessageStatus.none
  });

  ChatState copyWith({
     String? messageSendContent,
    List<Message>? messages,
    MessageStatus? messageStatus,
    ListMessageStatus? listMessageStatus
  }) {
    return ChatState(
      messageSendContent: messageSendContent ?? this.messageSendContent,
      messages: messages ?? this.messages,
      messageStatus: messageStatus ?? this.messageStatus,
      listMessageStatus: listMessageStatus ?? this.listMessageStatus
    );
  }
}


