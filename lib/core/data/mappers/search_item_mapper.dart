import 'package:clean_architecture_flutter_buscador/core/data/dto/search_item_dto.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';

abstract class SearchItemMapper {
  SearchItem dtoToEntity(SearchItemDTO dto);
  SearchItemDTO entityToDTO(SearchItem entity);
}
