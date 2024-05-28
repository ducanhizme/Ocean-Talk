part of 'search_bloc.dart';

abstract class SearchEvent {}

class FetchSearch extends SearchEvent {
  final String query;
  FetchSearch(this.query);
}

class SearchCleared extends SearchEvent {}
