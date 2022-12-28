import 'dart:io';

import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/usecases/search_by_text.dart';
import 'package:clean_architecture_flutter_buscador/core/utils/injection_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/github_response_fake.dart';

class ClientMock extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late Client client;
  late InjectionDependencies dependencies;
  setUpAll(() {
    client = ClientMock();
    dependencies = InjectionDependencies(client: client);
    dependencies();
    registerFallbackValue(FakeUri());
  });

  test('Deve retornar un usecase de SearchByText', () {
    final useCase = GetIt.I.get<SearchByText>();
    expect(useCase, isA<SearchByText>());
  });

  test('Deve retornar uma lista de entidades', () async {
    const String searchText = "flutter";

    final useCase = GetIt.I.get<SearchByText>();

    when(() => client.get(any())).thenAnswer(
        (invocation) async => Response(githutReponseFace, HttpStatus.ok));

    final result = await useCase(searchText);
    expect(result | null, isA<List<SearchItem>?>());
  });
}
