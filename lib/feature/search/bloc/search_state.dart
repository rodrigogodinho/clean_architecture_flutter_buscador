part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState implements SearchState {}

class SearchLoadingState implements SearchState {}

class SearchSuccessState implements SearchState {
  final List<SearchItem> list;

  SearchSuccessState(this.list);
}

class SearchErrorState implements SearchState {
  final FailureSearch error;

  SearchErrorState(this.error);
}
