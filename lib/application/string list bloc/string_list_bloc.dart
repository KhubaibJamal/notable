import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'string_list_state.dart';
part 'string_list_event.dart';

class StringListBlock extends Bloc<StringListEvent, StringListState> {
  final List<String> _strings = [];

  StringListBlock() : super(StringListInitial()) {
    on<LoadStrings>(_onLoadStrings);
    on<AddString>(_onAddString);
    on<RemoveString>(_onRemoveString);
  }

  void _onLoadStrings(LoadStrings event, Emitter<StringListState> emit) {
    emit(StringListLoading());
    try {
      emit(StringListLoaded(List.from(_strings)));
    } catch (e) {
      emit(StringListError());
    }
  }

  _onAddString(event, emit) {
    _strings.add(event.newString);
    emit(StringListLoaded(List.from(_strings)));
  }

  void _onRemoveString(RemoveString event, Emitter<StringListState> emit) {
    _strings.remove(event.stringToRemove);
    emit(StringListLoaded(List.from(_strings)));
  }
}
