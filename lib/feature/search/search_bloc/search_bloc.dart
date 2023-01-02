import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/errors/errors.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/usecases/search_by_text.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchInitialState()) {
    on<SearchByTextEvent>((event, emit) async {
      emit(SearchLoadingState());

      final result = await usecase(event.searchText);

      if (result is Right) {
        emit(SearchSuccessState((result | null) ?? <SearchItem>[]));
      } else if (result.fold((l) => l, (r) => null) is InvalidEmptyTextError) {
        emit(SearchInitialState());
      } else {
        final error = result.fold((l) => l, (r) => null);
        emit(SearchErrorState(error!));
      }
    }, transformer: debounce(const Duration(milliseconds: 800)));
  }

  EventTransformer<SearchEvent> debounce<SearchEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
