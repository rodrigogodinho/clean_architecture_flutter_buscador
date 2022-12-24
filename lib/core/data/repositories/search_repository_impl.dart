import 'package:clean_architecture_flutter_buscador/core/data/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter_buscador/core/data/mappers/search_item_mapper.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/errors/errors.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class SearchRepositoyImpl implements SearchRepository {
  final SearchDataSource dataSource;
  final SearchItemMapper mapper;

  SearchRepositoyImpl(this.dataSource, this.mapper);

  @override
  Future<Either<FailureSearch, List<SearchItem>?>> getSearchList(
      String? searchText) async {
    try {
      final listDTO = await dataSource.getSearchList(searchText);
      final listEntity = listDTO?.map((e) => mapper.dtoToEntity(e)).toList();
      return Right(listEntity);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Left(DataSourceError());
    }
  }
}
