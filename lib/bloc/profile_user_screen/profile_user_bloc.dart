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
        emit(state.copyWith(status: ProfileUserStatus.loading));
        final currentUser = await userRepository.getCurrentUser();
        await userRepository.addRequestFriend(currentUser, event.userStranger);
        emit(state.copyWith(status: ProfileUserStatus.success,requestStatus: RequestStatus.pending));
      } catch (e) {
        emit(state.copyWith(status: ProfileUserStatus.failure));
      }
    });

    on<RemoveRequestFriendEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ProfileUserStatus.loading));
        final currentUser = await userRepository.getCurrentUser();
        await userRepository.removeRequestFriend(currentUser, event.userStranger);
        emit(state.copyWith(status: ProfileUserStatus.success,requestStatus: RequestStatus.none));
      } catch (e) {
        emit(state.copyWith(status: ProfileUserStatus.failure));
      }
    });

    on<FetchProfileUser>((event, emit) async {
      try {
        emit(state.copyWith(status: ProfileUserStatus.loading));
        final currentUser = await userRepository.getCurrentUser();
        if(await userRepository.checkRequestFriend(currentUser, event.user)){
          emit(state.copyWith(status: ProfileUserStatus.success,requestStatus: RequestStatus.pending));
        }
        if(currentUser.friends.contains(event.user)){
          emit(state.copyWith(status: ProfileUserStatus.success,userType: UserType.friend,requestStatus: RequestStatus.accepted));
        }
        for (var element in currentUser.friends) {
          if(element.uid == event.user.uid){
            emit(state.copyWith(status: ProfileUserStatus.success,userType: UserType.friend));
            return;
          }
        }
      } catch (e) {
        emit(state.copyWith(status: ProfileUserStatus.failure));
      }
    });
  }
}
