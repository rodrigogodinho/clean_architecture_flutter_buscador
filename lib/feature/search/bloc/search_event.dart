part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchByTextEvent implements SearchEvent {
  final String searchText;

  SearchByTextEvent(this.searchText);
}
