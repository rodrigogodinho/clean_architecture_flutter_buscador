// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SearchItemDTO {
  final String id;
  final String name;
  final String description;
  final double score;

  SearchItemDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'score': score,
    };
  }

  factory SearchItemDTO.fromMap(Map<String, dynamic> map) {
    return SearchItemDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      score: map['score'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchItemDTO.fromJson(String source) =>
      SearchItemDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
