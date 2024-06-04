import 'package:bloc/bloc.dart';

import '../../data/models/app_user.dart';
import '../../data/repository/user_repository.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final UserRepository userRepository;
  FriendBloc({required this.userRepository}) : super(FriendState()) {
    on<FetchFriend>((event, emit) async {
      emit(FriendLoading());
      print("loadingg");
      try {
        final userList = await userRepository.getUsers();
        print("userList: ${userList[1].fullName}");
        emit(FriendFetched(userList));
      } catch (e) {
        print(e.toString());
        emit(FriendError(e.toString()));
      }
    });
  }
}
