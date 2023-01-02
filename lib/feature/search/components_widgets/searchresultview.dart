import 'package:clean_architecture_flutter_buscador/feature/search/bloc/typeview_bloc.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/components_widgets/gridviewsearch.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/components_widgets/listviewsearch.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';

class SearchResultView extends StatelessWidget {
  final SearchBloc bloc;
  final TypeViewBloc typeViewBloc;

  const SearchResultView({
    Key? key,
    required this.bloc,
    required this.typeViewBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final state = bloc.state;

          if (state is SearchInitialState) {
            return const Center(
              child: Text('Digite um texto'),
            );
          }

          if (state is SearchErrorState) {
            return const Center(
              child: Text('Houve um erro'),
            );
          }

          if (state is SearchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final list = (state as SearchSuccessState).list;

          return StreamBuilder(
              stream: typeViewBloc.stream,
              builder: (context, snapshot) {
                if (typeViewBloc.state.isGrid) {
                  return GridViewSearch(list: list);
                } else {
                  return ListViewSearch(list: list);
                }
              });
        });
  }
}
