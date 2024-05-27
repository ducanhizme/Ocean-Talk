import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_talk/bloc/social_login/social_login_bloc.dart';
import 'package:ocean_talk/data/repository/user_repository.dart';
import 'package:ocean_talk/presentation/screens/home_screen.dart';

import '../../common/common_widget.dart';
import '../../data/repository/authentication_repository.dart';

class SocialAuthentication extends StatelessWidget {
  const SocialAuthentication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginBloc(authRepository: RepositoryProvider.of<AuthenticationRepository>(context), userRepository: RepositoryProvider.of<UserRepository>(context)),
      child: BlocConsumer<SocialLoginBloc, SocialLoginState>(
        listener: (context, state) {
          if (state.status == SocialLoginStatus.success) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen(),));
          }
          else {
          }
        },
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSocialButton(
                  context, 'Google', 'assets/icon/google.png', () {
                context.read<SocialLoginBloc>().add(const SocialLoginGoogle());
              }),
              buildSocialButton(
                  context, 'Github', 'assets/icon/github.png', () {
                context.read<SocialLoginBloc>().add(const SocialLoginGithub());
              }),
              buildSocialButton(
                  context, 'Facebook',
                  'assets/icon/facebook.png', () {}),
            ],
          );
        },
      ),
    );
  }
}