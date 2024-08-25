import 'package:notable/domain/note/note_model.dart';
import 'package:notable/domain/note/note_service.dart';
import 'package:notable/presentation/utils/theme.dart';
import 'package:notable/presentation/utils/utils.dart';

class NoteRepo {
  NoteService noteService = NoteService();

  Future<void> addNote(NoteModel note) async {
    try {
      await noteService.addNote(note);
      Utils.showToast(message: "Note Added", color: CustomColors.success);
    } catch (e) {
      Utils.showToast(
          message: "Error while adding note: ${e.toString()}",
          color: CustomColors.error);
    }
  }

  Future<List<NoteModel>> getAllNotes() async {
    try {
      return noteService.getAllNotes();
    } catch (e) {
      Utils.showToast(
          message: "Error while fetching note: ${e.toString()}",
          color: CustomColors.error);
      return [];
    }
  }

  Future<void> updateNote(String id, NoteModel note) async {
    try {
      await noteService.updateNote(id, note);
      Utils.showToast(message: "Note Updated", color: CustomColors.success);
    } catch (e) {
      Utils.showToast(
          message: "Error while updating note: ${e.toString()}",
          color: CustomColors.error);
    }
  }

  Future<void> deleteNoteById(String id) async {
    try {
      await noteService.deleteNoteById(id);
      Utils.showToast(message: "Note Deleted", color: CustomColors.error);
    } catch (e) {
      Utils.showToast(
          message: "Error while deleting note: ${e.toString()}",
          color: CustomColors.error);
    }
  }
}
