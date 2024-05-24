
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocean_talk/bloc/register_event.dart';
import 'package:ocean_talk/bloc/register_state.dart';

import '../data/repository/authentication_repository.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository _authenticationRepository;
  RegisterBloc(this._authenticationRepository) : super(const RegisterState()){
    on<RegisterReset>((event, emit) {
      emit(state.copyWith(status: RegisterStatus.initial));
    });
    on<RegisterAutovalidateModeChanged>((event, emit) {
      emit(state.copyWith(autovalidateMode: event.autovalidate));
    });
    on<RegisterFullNameChanged>((event, emit) {
      emit(state.copyWith(username: event.fullName));
    });
    on<RegisterDateOfBirthChanged>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.dateOfBirth));
    });
    on<RegisterGenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));}
    );
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(status: RegisterStatus.submitting));
      bool signUpSuccess = await _authenticationRepository.signUp(email: state.email, password: state.password);
      if (signUpSuccess) {
        emit(state.copyWith(status: RegisterStatus.success));
      } else {
        emit(state.copyWith(status: RegisterStatus.failure));
      }
    });
  }
}
