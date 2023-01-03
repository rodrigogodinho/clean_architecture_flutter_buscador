import 'package:clean_architecture_flutter_buscador/core/data/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter_buscador/core/data/dto/search_item_dto.dart';
import 'package:clean_architecture_flutter_buscador/core/data/mappers/search_item_mapper.dart';
import 'package:clean_architecture_flutter_buscador/core/data/mappers/search_item_mapper_github.dart';
import 'package:clean_architecture_flutter_buscador/core/data/repositories/search_repository_impl.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

void main() {
  late SearchRepositoyImpl repository;
  late SearchDataSource dataSource;
  late SearchItemMapper mapper;

  setUpAll(() {
    dataSource = SearchDataSourceMock();
    mapper = SearchItemMapperGithub();
    repository = SearchRepositoyImpl(dataSource, mapper);
  });

  test('Deve retornar uma lista de entidades', () async {
    const String searchText = "flutter";
    final dto1 = SearchItemDTO(
        id: "1",
        name: "DTO",
        description: "Sou um data transfer object",
        score: 5);

    when(() => dataSource.getSearchList(searchText))
        .thenAnswer((invocation) async => [dto1]);

    final result = await repository.getSearchList(searchText);
    final list = result.getOrElse(() => null);

    expect(result, isA<Right>());
    expect(list, isA<List<SearchItem>?>());
    expect(list?.first, isA<SearchItem>());
    expect(list?.first.name, equals("DTO"));
  });
}
