part of 'authentication_bloc.dart';
enum AuthenticationStatus { loading, authenticated, unauthenticated }
class AuthenticationState {
   final AuthenticationStatus status;
   final String msg;
    const AuthenticationState({ this.status = AuthenticationStatus.loading,  this.msg=""});
    copyWith({AuthenticationStatus? status, String? msg}) {
        return AuthenticationState(
            status: status ?? this.status,
            msg: msg ?? this.msg,
        );
    }
}

