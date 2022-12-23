// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/repositories/search_repository.dart';

abstract class GetSearchList {
  Future<Either<Exception, List<SearchItem>?>> call(String? searchText);
}

class GetSearchListImpl implements GetSearchList {
  final SearchRepository repository;

  GetSearchListImpl({
    required this.repository,
  });

  @override
  Future<Either<Exception, List<SearchItem>?>> call(String? searchText) async {
    if (searchText == null) {
      return Left(Exception('String inválida'));
    } else if (searchText.trim().isEmpty) {
      return Left(Exception('String vazia'));
    }
    return repository.getSearchList(searchText);
  }
}
