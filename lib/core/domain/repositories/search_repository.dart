import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Exception, List<SearchItem>?>> getSearchList(
      String? searchText);
}
