
import 'package:flutter/cupertino.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterReset extends RegisterEvent {
  const RegisterReset();
}


class RegisterAutovalidateModeChanged extends RegisterEvent {
  final AutovalidateMode autovalidate;
  const RegisterAutovalidateModeChanged(this.autovalidate);
}

class RegisterFullNameChanged extends RegisterEvent {
  final String fullName;
  const RegisterFullNameChanged(this.fullName);
}

class RegisterDateOfBirthChanged extends RegisterEvent {
  final String dateOfBirth;
  const RegisterDateOfBirthChanged(this.dateOfBirth);
}

class RegisterGenderChanged extends RegisterEvent {
  final String gender;
  const RegisterGenderChanged(this.gender);
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  const RegisterConfirmPasswordChanged(this.confirmPassword);
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;
  const RegisterSubmitted(this.email, this.password);
}