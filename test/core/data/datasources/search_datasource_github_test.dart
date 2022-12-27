import 'dart:io';

import 'package:clean_architecture_flutter_buscador/core/data/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter_buscador/core/data/datasources/search_datasource_github.dart';
import 'package:clean_architecture_flutter_buscador/core/data/dto/search_item_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/github_response_fake.dart';

class ClientMock extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late SearchDataSource datasource;
  late Client client;

  setUpAll(() {
    client = ClientMock();
    datasource = SearchDatasourceGithub(client);
    registerFallbackValue(FakeUri());
  });

  test('Validando datasource para Github', () async {
    const String searchText = "flutter";

    when(() => client.get(any())).thenAnswer(
        (invocation) async => Response(githutReponseFace, HttpStatus.ok));

    final result = await datasource.getSearchList(searchText);
    expect(result, isA<List<SearchItemDTO>?>());
  });
}
