part of 'string_list_bloc.dart';

abstract class StringListState extends Equatable {
  const StringListState();

  @override
  List<Object> get props => [];
}

class StringListInitial extends StringListState {}

class StringListLoading extends StringListState {}

class StringListLoaded extends StringListState {
  final List<String> strings;

  const StringListLoaded(this.strings);

  @override
  List<Object> get props => [strings];
}

class StringListError extends StringListState {}
