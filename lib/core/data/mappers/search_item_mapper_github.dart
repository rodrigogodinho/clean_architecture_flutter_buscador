import 'package:clean_architecture_flutter_buscador/core/data/dto/search_item_dto.dart';
import 'package:clean_architecture_flutter_buscador/core/data/mappers/search_item_mapper.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';

class SearchItemMapperGithub implements SearchItemMapper {
  @override
  SearchItem dtoToEntity(SearchItemDTO dto) {
    return SearchItem(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      score: dto.score,
    );
  }

  @override
  SearchItemDTO entityToDTO(SearchItem entity) {
    return SearchItemDTO(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      score: entity.score,
    );
  }
}
