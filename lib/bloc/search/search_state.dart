part of 'search_bloc.dart';

class SearchState {
  final String query;
  SearchState({this.query = ""});
  copyWith({String? query}) {
    return SearchState(query: query ?? this.query);
  }
}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<AppUser> listUser;
  SearchSuccess(this.listUser);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

