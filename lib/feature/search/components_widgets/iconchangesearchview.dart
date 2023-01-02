import 'package:clean_architecture_flutter_buscador/feature/search/bloc/typeview_bloc.dart';
import 'package:flutter/material.dart';

class IconChangeSearchView extends StatelessWidget {
  final TypeViewBloc typeViewBloc;

  const IconChangeSearchView({
    Key? key,
    required this.typeViewBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: typeViewBloc.stream,
      builder: (context, snapshot) {
        return IconButton(
          icon: Icon(
            typeViewBloc.state.isGrid ? Icons.list : Icons.grid_view,
          ),
          tooltip: 'Modifica a visualização',
          onPressed: () {
            typeViewBloc.add(ChangeTypeViewEvent());
          },
        );
      },
    );
  }
}
