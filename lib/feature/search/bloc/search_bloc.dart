import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/errors/errors.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/usecases/search_by_text.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchInitialState()) {
    on<SearchByTextEvent>((event, emit) async {
      emit(SearchLoadingState());
      final result = await usecase(event.searchText);
      emit(result.fold((l) => SearchErrorState(l),
          (r) => SearchSuccessState(r ?? <SearchItem>[])));
    });
  }
}
