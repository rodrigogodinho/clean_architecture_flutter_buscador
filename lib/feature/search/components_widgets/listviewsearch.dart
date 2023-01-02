import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:flutter/material.dart';

class ListViewSearch extends StatelessWidget {
  const ListViewSearch({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<SearchItem> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        final item = list[index];
        return Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Card(
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(item.description),
            ),
          ),
        );
      },
    );
  }
}
