// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_flutter_buscador/core/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/repositories/search_repository.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<SearchItem>?>> call(String? searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl({
    required this.repository,
  });

  @override
  Future<Either<FailureSearch, List<SearchItem>?>> call(
      String? searchText) async {
    if (searchText == null) {
      return Left(InvalidTextError());
    } else if (searchText.trim().isEmpty) {
      return Left(InvalidEmptyTextError());
    }
    return repository.getSearchList(searchText);
  }
}
