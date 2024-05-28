import 'package:bloc/bloc.dart';
import '../../data/models/app_user.dart';
import '../../data/repository/user_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UserRepository userAuthenticationRepository;
  SearchBloc({required this.userAuthenticationRepository}) : super(SearchState()) {
    on<FetchSearch>((event, emit) async {
        try{
          emit(SearchLoading());
          final userList = await userAuthenticationRepository.searchUsers(event.query);
          emit(SearchSuccess(userList));
        } catch (e) {
          emit(SearchError("Failed to search user"));
        }
    });
    on<SearchCleared>((event, emit) async {
      emit(SearchState());
    });
  }
}
