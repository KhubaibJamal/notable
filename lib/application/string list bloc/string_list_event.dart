part of 'string_list_bloc.dart';

abstract class StringListEvent extends Equatable {
  const StringListEvent();

  @override
  List<Object> get props => [];
}

class LoadStrings extends StringListEvent {}

class AddString extends StringListEvent {
  final String newString;
  const AddString(this.newString);

  @override
  List<Object> get props => [newString];
}

class RemoveString extends StringListEvent {
  final String stringToRemove;

  const RemoveString(this.stringToRemove);

  @override
  List<Object> get props => [stringToRemove];
}
