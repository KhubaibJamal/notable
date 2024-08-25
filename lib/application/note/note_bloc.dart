import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:notable/domain/note/note_model.dart';
import 'package:notable/infrastructure/repositories/note_repo.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteRepo noteRepo = NoteRepo();

  NoteBloc() : super(NoteInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<SearchNotes>(_onSearchNotes);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      final notes = await noteRepo.getAllNotes();
      notes.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      emit(NoteLoaded(notes));
    } catch (e) {
      if (kDebugMode) {
        print("ERROR WHILE GETTING NOTES");
      }
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      await noteRepo.addNote(event.note);
      final notes = await noteRepo.getAllNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      if (kDebugMode) {
        print("ERROR WHILE ADDING NOTES");
      }
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try {
      await noteRepo.updateNote(event.note.id, event.note);
      final notes = await noteRepo.getAllNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      if (kDebugMode) {
        print("ERROR WHILE UPDATING NOTES");
      }
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try {
      await noteRepo.deleteNoteById(event.id);
      final notes = await noteRepo.getAllNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      if (kDebugMode) {
        print("ERROR WHILE DELETING NOTES");
      }
    }
  }

  void _onSearchNotes(SearchNotes event, Emitter<NoteState> emit) {
    if (state is NoteLoaded) {
      final notes = (state as NoteLoaded)
          .notes
          .where((note) =>
              note.title != null &&
              note.title!.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(NoteLoaded(notes));
    }
  }
}
