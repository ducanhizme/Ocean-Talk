part of 'social_login_bloc.dart';

enum SocialLoginStatus { initial, loading, success, failure }

class SocialLoginState {
  final SocialLoginStatus status;
  final String message;

  const SocialLoginState(
      {this.status = SocialLoginStatus.initial, this.message = ''});

  copyWith({SocialLoginStatus? status, String? message}) {
    return SocialLoginState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
