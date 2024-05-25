import 'package:flutter/cupertino.dart';

enum RegisterStatus { initial, submitting, success, failure }

class RegisterState {
  final AutovalidateMode autovalidateMode;
  final String fullName;

  final String dateOfBirth;
  final String gender;
  final String email;
  final String password;
  final String confirmPassword;
  final RegisterStatus status;

  const RegisterState(
      {this.status = RegisterStatus.initial,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.fullName = "",
      this.dateOfBirth = "",
      this.gender = "",
      this.email = "",
      this.password = "",
      this.confirmPassword = ""});

  copyWith({
    RegisterStatus? status,
    AutovalidateMode? autovalidateMode,
    String? username,
    String? dateOfBirth,
    String? gender,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterState(
      status: status ?? this.status,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      fullName: username ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
