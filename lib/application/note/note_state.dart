part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  const NoteLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class SearchNotes extends NoteEvent {
  final String query;

  const SearchNotes(this.query);

  @override
  List<Object> get props => [query];
}
