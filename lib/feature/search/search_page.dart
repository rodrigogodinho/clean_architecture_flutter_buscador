import 'package:clean_architecture_flutter_buscador/feature/search/bloc/typeview_bloc.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/components_widgets/iconchangesearchview.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/components_widgets/searchresultview.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc bloc;
  late TypeViewBloc typeViewBloc;

  @override
  void initState() {
    super.initState();
    bloc = GetIt.I.get<SearchBloc>();
    typeViewBloc = GetIt.I.get<TypeViewBloc>();
  }

  @override
  void dispose() {
    bloc.close();
    typeViewBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Repositories Search'),
        actions: [
          IconChangeSearchView(typeViewBloc: typeViewBloc),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => bloc.add(SearchByTextEvent(value)),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Expanded(
            child: SearchResultView(bloc: bloc, typeViewBloc: typeViewBloc),
          )
        ],
      ),
    );
  }
}
