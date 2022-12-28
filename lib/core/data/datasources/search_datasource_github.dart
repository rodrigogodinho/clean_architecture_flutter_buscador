import 'dart:convert';
import 'dart:io';

import 'package:clean_architecture_flutter_buscador/core/data/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter_buscador/core/data/dto/search_item_dto.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart';

extension on String {
  normalize() {
    return replaceAll(" ", "+");
  }
}

class SearchDatasourceGithub implements SearchDataSource {
  final Client client;

  SearchDatasourceGithub(this.client);

  @override
  Future<List<SearchItemDTO>?> getSearchList(String? searchText) async {
    Uri uri = Uri(
      host: "api.github.com",
      path: "/search/repositories",
      scheme: "https",
      queryParameters: {'q': searchText?.normalize()},
    );

    final response = await client.get(uri);
    try {
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final list = json["items"] as List;
        final listDTO = list.map((e) => SearchItemDTO.fromMap(e)).toList();
        return listDTO;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        throw Exception('Não me convidaram para esta festa pobre.');
      } else {
        throw Exception(
            'Pode ser um erro de conexão, erro no servidor ou alguém esqueceu de pagar a internet.');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
