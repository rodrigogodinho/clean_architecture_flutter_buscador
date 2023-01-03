import 'package:clean_architecture_flutter_buscador/core/domain/entities/search_item.dart';
import 'package:flutter/material.dart';

class GridViewSearch extends StatelessWidget {
  const GridViewSearch({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<SearchItem> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: 1.5,
      ),
      itemCount: list.length,
      itemBuilder: (_, index) {
        final item = list[index];
        return Card(
          child: GridTile(
            header: GridTileBar(
              backgroundColor: Colors.white,
              title: Text(
                item.name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.white,
              title: Text(
                '${item.score} \u2B50',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            child: GridTileBar(
              backgroundColor: Colors.white,
              title: Text(
                item.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
