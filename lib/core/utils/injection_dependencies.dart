// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_flutter_buscador/core/data/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter_buscador/core/data/datasources/search_datasource_github.dart';
import 'package:clean_architecture_flutter_buscador/core/data/mappers/search_item_mapper.dart';
import 'package:clean_architecture_flutter_buscador/core/data/mappers/search_item_mapper_github.dart';
import 'package:clean_architecture_flutter_buscador/core/data/repositories/search_repository_impl.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/repositories/search_repository.dart';
import 'package:clean_architecture_flutter_buscador/core/domain/usecases/search_by_text.dart';
import 'package:clean_architecture_flutter_buscador/feature/search/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class InjectionDependencies {
  Client client;

  InjectionDependencies({required this.client});

  void call() {
    final GetIt getIt = GetIt.I;
    getIt.registerSingleton<Client>(client);
    getIt.registerSingleton<SearchDataSource>(SearchDatasourceGithub(getIt()));
    getIt.registerSingleton<SearchItemMapper>(SearchItemMapperGithub());
    getIt.registerSingleton<SearchRepository>(
        SearchRepositoyImpl(getIt(), getIt()));
    getIt
        .registerSingleton<SearchByText>(SearchByTextImpl(repository: getIt()));
    getIt.registerSingleton<SearchBloc>(SearchBloc(getIt()));
  }
}
