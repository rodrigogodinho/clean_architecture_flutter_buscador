import 'package:bloc/bloc.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/errors/errors.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/usecases/search_by_text.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/search_bloc/search_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchBytextMock extends Mock implements SearchByText {}

class FakeInvalidText extends Fake {}

void main() {
  late Bloc bloc;
  late SearchByText usecase;

  setUpAll(() {
    usecase = SearchBytextMock();
    bloc = SearchBloc(usecase);
    registerFallbackValue(FakeInvalidText());
  });

  test('Deve retornar os estados na ordem esperada', () {
    const searchText = "Flutter";

    when(() => usecase.call(any()))
        .thenAnswer((invocation) async => Right(<SearchItem>[]));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoadingState>(),
          isA<SearchSuccessState>(),
        ]));

    bloc.add(SearchByTextEvent(searchText));
  });

  test('Deve retornar estado inicial porque o texto é vazio', () {
    const searchText = "";

    when(() => usecase.call(any()))
        .thenAnswer((invocation) async => Left(InvalidEmptyTextError()));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoadingState>(),
          isA<SearchInitialState>(),
        ]));

    bloc.add(SearchByTextEvent(searchText));
  });

  test('Deve retornar estado de erro', () {
    when(() => usecase.call(any()))
        .thenAnswer((invocation) async => Left(InvalidTextError()));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoadingState>(),
          isA<SearchErrorState>(),
        ]));

    bloc.add(SearchByTextEvent(
        "É uma string, porem a mágica do mocktail fará que o usecase a entenda como inválida!!!"));
  });
}
