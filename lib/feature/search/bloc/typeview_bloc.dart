import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'typeview_event.dart';
part 'typeview_state.dart';

class TypeViewBloc extends Bloc<TypeViewEvent, TypeViewState> {
  TypeViewBloc() : super(const TypeViewState(isGrid: false)) {
    on<ChangeTypeViewEvent>((event, emit) {
      emit(TypeViewState(isGrid: !state.isGrid));
    });
  }
}
