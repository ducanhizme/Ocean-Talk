part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }
class LoginState {
  final String email;
  final String password;
  final LoginStatus status;
  const LoginState({this.status= LoginStatus.initial, this.email = "", this.password = ""});
  copyWith({String? email, String? password,LoginStatus? status}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}

