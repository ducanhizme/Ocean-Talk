import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../data/models/app_user.dart';
import '../../data/repository/user_repository.dart';

part 'profile_user_event.dart';

part 'profile_user_state.dart';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
  final UserRepository userRepository;

  ProfileUserBloc(this.userRepository) : super(const ProfileUserState()) {
    on<AddRequestFriendEvent>(handleRequestFriend);
    on<RemoveRequestFriendEvent>(handleCancelRequestFriend);
    on<AcceptRequestFriendEvent>(handleAcceptRequestFriend);
    on<FetchProfileUser>(handleFetchProfileUser);
  }

  FutureOr<void> handleFetchProfileUser(event, emit) async {
    try {
      emit(state.copyWith(status: ProfileUserStatus.loading));
      final currentUser = await userRepository.getCurrentUser();
      for (var element in currentUser.friends) {
        if(element.uid == event.user.uid){
          emit(state.copyWith(
            status: ProfileUserStatus.success,
            userType: UserType.friend,
            requestStatus: RequestStatus.done));
          continue;
        }
        else {
          emit(state.copyWith(
              status: ProfileUserStatus.success,
              userType: UserType.stranger,
              requestStatus: RequestStatus.none));
        }
      }
      final snapshot =await userRepository
          .checkRequestFriend(currentUser, event.user)
          .first;
      if (snapshot.data()?['requestUserRole'] == 'receiver') {
        emit(state.copyWith(
            status: ProfileUserStatus.success,
            requestStatus: RequestStatus.pending));
      }
      if (snapshot.data()?['requestUserRole'] == 'sender') {
        emit(state.copyWith(
            status: ProfileUserStatus.success,
            requestStatus: RequestStatus.receive));
      }
    } catch (e) {
      emit(state.copyWith(status: ProfileUserStatus.failure));
    }
  }

  FutureOr<void> handleAcceptRequestFriend(event, emit) async {
    try {
      emit(state.copyWith(requestStatus: RequestStatus.loading));
      final currentUser = await userRepository.getCurrentUser();
      await userRepository.removeRequestFriend(
          currentUser, event.userStranger);
      await userRepository.acceptRequestFriend(currentUser, event.userStranger);
      emit(state.copyWith(
          status: ProfileUserStatus.success,
          userType: UserType.friend,
          requestStatus: RequestStatus.done));
    } catch (e) {
      emit(state.copyWith(status: ProfileUserStatus.failure));
    }
  }

  FutureOr<void> handleCancelRequestFriend(event, emit) async {
    try {
      emit(state.copyWith(requestStatus: RequestStatus.loading));
      final currentUser = await userRepository.getCurrentUser();
      await userRepository.removeRequestFriend(
          currentUser, event.userStranger);
      emit(state.copyWith(
          status: ProfileUserStatus.success,
          requestStatus: RequestStatus.none));
    } catch (e) {
      emit(state.copyWith(status: ProfileUserStatus.failure));
    }
  }

  FutureOr<void> handleRequestFriend(event, emit) async {
    try {
      emit(state.copyWith(requestStatus: RequestStatus.loading));
      final currentUser = await userRepository.getCurrentUser();
      await userRepository.addRequestFriend(currentUser, event.userStranger);
      emit(state.copyWith(
          status: ProfileUserStatus.success,
          requestStatus: RequestStatus.pending));
    } catch (e) {
      emit(state.copyWith(status: ProfileUserStatus.failure));
    }
  }
}
