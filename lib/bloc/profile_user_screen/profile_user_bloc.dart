import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../data/models/app_user.dart';
import '../../data/repository/user_repository.dart';

part 'profile_user_event.dart';

part 'profile_user_state.dart';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
  final UserRepository userRepository;

  ProfileUserBloc(this.userRepository) : super(const ProfileUserState()) {
    on<AddRequestFriendEvent>((event, emit) async {
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
    });

    on<RemoveRequestFriendEvent>((event, emit) async {
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
    });

    on<AcceptRequestFriendEvent>((event, emit) async {
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
    });


    on<FetchProfileUser>((event, emit) async {
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
        final completer = Completer<void>();
        final subscription = userRepository
            .checkRequestFriend(currentUser, event.user)
            .listen((snapshot) {
          if (snapshot.data()?['requestUserRole'] == 'receiver' &&
              snapshot.data()?['requestStatus'] == 'requested') {
            emit(state.copyWith(
                status: ProfileUserStatus.success,
                requestStatus: RequestStatus.pending));
          }
          if (snapshot.data()?['requestUserRole'] == 'sender' &&
              snapshot.data()?['requestStatus'] == 'requested') {
            emit(state.copyWith(
                status: ProfileUserStatus.success,
                requestStatus: RequestStatus.receive));
          }
        });
        subscription.onDone(() => completer.complete());
        await completer.future;
      } catch (e) {
        emit(state.copyWith(status: ProfileUserStatus.failure));
      }
    });
  }
}
