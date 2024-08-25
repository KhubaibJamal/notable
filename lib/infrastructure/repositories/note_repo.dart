import 'package:flutter/material.dart';
import 'package:notable/domain/note/note_model.dart';
import 'package:notable/domain/note/note_service.dart';
import 'package:notable/presentation/utils/utils.dart';

class NoteRepo {
  NoteService noteService = NoteService();

  Future<void> addNote(NoteModel note) async {
    try {
      await noteService.addNote(note);
    } catch (e) {
      Utils.showToast(message: "Error: ${e.toString()}", color: Colors.red);
    }
  }

  Future<List<NoteModel>> getAllNotes() async {
    try {
      return noteService.getAllNotes();
    } catch (e) {
      Utils.showToast(message: "Error: ${e.toString()}", color: Colors.red);
      return [];
    }
  }

  Future<void> updateNote(String id, NoteModel note) async {
    try {
      await noteService.updateNote(id, note);
    } catch (e) {
      Utils.showToast(message: "Error: ${e.toString()}", color: Colors.red);
    }
  }

  Future<void> deleteNoteById(String id) async {
    try {
      await noteService.deleteNoteById(id);
    } catch (e) {
      Utils.showToast(message: "Error: ${e.toString()}", color: Colors.red);
    }
  }
}
