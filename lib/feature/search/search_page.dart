import 'package:clean_architecture_flutter_buscador/core/domain/errors/errors.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc bloc = GetIt.I.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Search'),
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
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;
                  if (state is SearchInitialState ||
                      (state is SearchErrorState &&
                          state.error is InvalidEmptyTextError)) {
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

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      final item = list[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.description),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
