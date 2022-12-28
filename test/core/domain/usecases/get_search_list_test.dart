import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/errors/errors.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/repositories/search_repository.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements SearchRepository {}

void main() {
  late SearchRepository repository;
  late SearchByText usecase;

  setUpAll(() {
    repository = RepositoryMock();
    usecase = SearchByTextImpl(repository: repository);
  });

  test('Deve retornar uma lista de resultados', () async {
    const String searchText = "flutter";

    when(() => repository.getSearchList(searchText))
        .thenAnswer((invocation) async => const Right(<SearchItem>[]));

    var result = await usecase(searchText);
    expect(result, isA<Right>());
    expect(result.getOrElse(() => null), isA<List<SearchItem>?>());
    //  o dartz permite escrever a mesma linha de cima na notação abaixo
    // trocando o método getOrElse pelo uso do pipe
    expect(result | null, isA<List<SearchItem>?>());
  });

  test('Deve retornar uma exception cuando string é inválida', () async {
    String? searchText;

    when(() => repository.getSearchList(searchText))
        .thenAnswer((invocation) async => const Right(<SearchItem>[]));

    var result = await usecase(searchText);
    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<InvalidTextError>());

    searchText = "";
    result = await usecase(searchText);
    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<InvalidEmptyTextError>());

    searchText = "     ";
    result = await usecase(searchText);
    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<InvalidEmptyTextError>());
  });
}
