
import 'package:bloc/bloc.dart';
import 'package:ocean_talk/bloc/register/register_event.dart';
import 'package:ocean_talk/bloc/register/register_state.dart';
import '../../data/models/app_user.dart';
import '../../data/repository/authentication_repository.dart';
import '../../data/repository/user_repository.dart';
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  RegisterBloc({required this.userRepository ,required this.authenticationRepository}) : super(const RegisterState()){
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
      bool signUpSuccess = await authenticationRepository.signUp(email: state.email, password: state.password);
      if (signUpSuccess) {
        final firebaseUser = authenticationRepository.getCurrentUser();
        final appUser = AppUser(
          uid: firebaseUser!.uid,
          email: firebaseUser.email!,
          fullName: state.fullName,
          dateOfBirth: state.dateOfBirth,
          gender: state.gender,
          displayImage: "",
        );
        userRepository.addUser(appUser);
        emit(state.copyWith(status: RegisterStatus.success));
      } else {
        emit(state.copyWith(status: RegisterStatus.failure));
      }
    });
  }
}
