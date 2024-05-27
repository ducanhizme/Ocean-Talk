import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/repository/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  LoginBloc({required this.authenticationRepository}) : super(const LoginState()) {
    on<LoginReset>((event, emit) {
      emit(state.copyWith(status: LoginStatus.initial));
    });
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginSubmitted>((event, emit) async {
      try{
        await authenticationRepository.login(email: state.email, password: state.password);
        emit(state.copyWith(status: LoginStatus.success));
      }on FirebaseAuthException catch(e){
        switch(e.code){
          case 'user-not-found':
            emit(state.copyWith(status: LoginStatus.failure, msg: 'User not found'));
            break;
          case 'wrong-password':
            emit(state.copyWith(status: LoginStatus.failure, msg: 'Wrong password'));
            break;
          case 'invalid-email':
            emit(state.copyWith(status: LoginStatus.failure, msg: 'Invalid email'));
            break;
          default:
            emit(state.copyWith(status: LoginStatus.failure, msg: 'Login Failed. Please try again later.'));
        }
      }
    });
  }
}
