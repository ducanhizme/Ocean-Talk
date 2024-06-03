part of 'profile_user_bloc.dart';
enum UserType{
  stranger,
  friend,
}

enum RequestStatus {
  none,
  pending,
  accepted,
  rejected,
}

enum ProfileUserStatus {
  init,
  loading,
  success,
  failure,
}

class ProfileUserState {
  final UserType userType;
  final RequestStatus requestStatus;
  final ProfileUserStatus status;
   const ProfileUserState({this.status=ProfileUserStatus.init, this.userType = UserType.stranger, this.requestStatus = RequestStatus.none});

  copyWith({ ProfileUserStatus? status ,UserType? userType, RequestStatus? requestStatus}) {
    return ProfileUserState(userType: userType ?? this.userType, requestStatus: requestStatus ?? this.requestStatus ,status: status ?? this.status);
  }
}








