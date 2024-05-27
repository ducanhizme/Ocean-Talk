import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  AuthenticationBloc({required this.authenticationRepository}) : super(const AuthenticationState()) {
    on<AuthenticationStarted>((event, emit) async {
      emit(state.copyWith(status: AuthenticationStatus.loading));
      if(authenticationRepository.getCurrentUser()!=null){
        print("authenticated");
        emit(state.copyWith(status: AuthenticationStatus.authenticated));
      }else{
        emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
        print("unauthenticated");
      }
    });

    on<AuthenticationEnded>((event, emit) async {
      authenticationRepository.logout();
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    });
  }
}
