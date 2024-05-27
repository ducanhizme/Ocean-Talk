import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_talk/data/models/app_user.dart';
import 'package:ocean_talk/data/repository/authentication_repository.dart';

import '../../data/repository/user_repository.dart';

part 'social_login_event.dart';

part 'social_login_state.dart';

class SocialLoginBloc extends Bloc<SocialLoginEvent, SocialLoginState> {
  final AuthenticationRepository authRepository;
  final UserRepository userRepository;

  SocialLoginBloc({required this.userRepository, required this.authRepository})
      : super(const SocialLoginState()) {
    on<SocialLoginGoogle>(_handleSocialLogin);
    on<SocialLoginGithub>(_handleSocialLogin);
  }

  _handleSocialLogin(
      SocialLoginEvent event, Emitter<SocialLoginState> emit) async {
    try {
      UserCredential userCredential;
      if (event is SocialLoginGoogle) {
        userCredential = await authRepository.loginWithGoogle();
      } else if (event is SocialLoginGithub) {
        userCredential = await authRepository.loginWithGitHub();
      } else {
        throw Exception('Invalid event');
      }

      final userFromFirestore =
          await userRepository.getUserByID(userCredential.user!.uid);
      if (!userFromFirestore.exists) {
        await userRepository.addUser(AppUser(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email!,
          fullName: userCredential.user!.displayName!,
          displayImage: userCredential.user!.photoURL!,
        ));
      }

      emit(state.copyWith(
          status: SocialLoginStatus.success,
          message:
              'Logged in with ${event is SocialLoginGoogle ? 'Google' : 'Github'}'));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: SocialLoginStatus.failure,
          message:
              'Failed to login with ${event is SocialLoginGoogle ? 'Google' : 'Github'}'));
    }
  }
}
