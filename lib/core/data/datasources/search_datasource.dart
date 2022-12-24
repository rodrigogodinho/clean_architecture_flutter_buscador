import 'package:clean_architecture_flutter_buscador/core/data/dto/search_item_dto.dart';

abstract class SearchDataSource {
  Future<List<SearchItemDTO>?> getSearchList(String? searchText);
}
