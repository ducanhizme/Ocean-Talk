part of 'login_bloc.dart';

enum LoginStatus { initial, submitting, success, failure }
class LoginState {
  final String email;
  final String password;
  final LoginStatus status;
  final String msg;
  const LoginState({this.status= LoginStatus.initial, this.email = "", this.password = "", this.msg=""});
  copyWith({String? email, String? password,LoginStatus? status, String?msg }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }
}

