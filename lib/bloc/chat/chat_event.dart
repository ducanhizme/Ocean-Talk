part of 'chat_bloc.dart';


class ChatEvent {}

class ChatStarted extends ChatEvent{
  final String receiversUid;
  ChatStarted(this.receiversUid);
}

class UpdateMessage extends ChatEvent {
  final List<Message> messages;
  UpdateMessage(this.messages);
}

class SendMessage extends ChatEvent {
  final String messageType;
  final List<String> receiversUid;
  SendMessage(this.receiversUid, this.messageType);
}

class TextMessageChanged extends ChatEvent {
  final String text;
  TextMessageChanged(this.text);
}