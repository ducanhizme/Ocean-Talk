part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginReset extends LoginEvent {
  const LoginReset();
}

class LoginEmailChanged extends LoginEvent {
  final String email;
  const LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  const LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  const LoginSubmitted(this.email, this.password);
}
