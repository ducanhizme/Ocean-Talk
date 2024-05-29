part of 'social_login_bloc.dart';


abstract class SocialLoginEvent {
  const SocialLoginEvent();
}

class SocialLoginReset extends SocialLoginEvent {
  const SocialLoginReset();
}

class SocialLoginGoogle extends SocialLoginEvent {
  const SocialLoginGoogle();
}

class SocialLoginGithub extends SocialLoginEvent {
  const SocialLoginGithub();
}

class SocialLoginFacebook extends SocialLoginEvent {
  const SocialLoginFacebook();
}
