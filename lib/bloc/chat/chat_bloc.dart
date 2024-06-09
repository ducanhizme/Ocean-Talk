import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_talk/common/common_function.dart';

import '../../data/models/message.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/repository/user_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final UserRepository userRepository;
  StreamSubscription<QuerySnapshot<Map<String,dynamic>>>? _messagesSubscription;
  ChatBloc(this.userRepository, {required this.chatRepository}) : super(ChatState()) {
    on<ChatStarted>(_handlerChatStarted);
    on<TextMessageChanged>(_handlerTextMessageChanged);
    on<SendMessage>(_handlerSendMessage);
    on<UpdateMessage>(_handlerUpdateMessage);
  }

  Future<void> _handlerSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(messageStatus: MessageStatus.sending));
      String senderId = await _getUserCurrentID();
      Message message = Message(
        senderId: senderId,
        content: state.messageSendContent,
        timestamp: formatTime(DateTime.now()),
      );
      await chatRepository.sendMessage(event.receiversUid, senderId, message);
      emit(state.copyWith(messageStatus: MessageStatus.sent));
    } on Exception {
      emit(state.copyWith(messageStatus: MessageStatus.failed));
    }
  }

  Future<String> _getUserCurrentID() async {
    final user = await userRepository.getCurrentUser();
    return user.uid;
  }

  void _handlerTextMessageChanged(TextMessageChanged event, Emitter<ChatState> emit) {
    emit(state.copyWith(messageSendContent: event.text));
  }

  @override
  Future<void> close() {
   _messagesSubscription?.cancel();
    return super.close();
  }



  _handlerChatStarted(ChatStarted event, Emitter<ChatState> emit) async {
  _messagesSubscription?.cancel();
  String currentUserId = await _getUserCurrentID();
  _messagesSubscription = chatRepository.getMessages([event.receiversUid], currentUserId).listen((event) {
    List<Message> messages = event.docs.map((e) => Message.fromFirestore(e)).toList();
    add(UpdateMessage(messages));
  });

}


  _handlerUpdateMessage(UpdateMessage event, Emitter<ChatState> emit) {
    emit(state.copyWith(messages: event.messages , listMessageStatus: ListMessageStatus.updated));
  }
}
