import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notable/domain/note/note_model.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addNote(NoteModel note) async {
    try {
      var docId = _firestore.collection('events').doc();

      NoteModel noteModel = NoteModel(
        id: docId.id,
        title: note.title,
        description: note.description,
        createAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _firestore
          .collection('notes')
          .doc(docId.id)
          .set(noteModel.toJson());
    } catch (e) {
      print("Failed to add note: $e");
    }
  }

  Future<List<NoteModel>> getAllNotes() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('notes').get();

      List<NoteModel> notes = querySnapshot.docs
          .map((doc) => NoteModel.fromJson(doc.data() as Map<String, dynamic>)
              .copyWith(id: doc.id))
          .toList();

      notes.sort((a, b) => b.createAt!.compareTo(a.createAt!));

      return notes;
    } catch (e) {
      print("Failed to get notes: $e");
      return [];
    }
  }

  Future<void> updateNote(String id, NoteModel note) async {
    try {
      NoteModel noteModel = NoteModel(
        id: id,
        title: note.title,
        description: note.description,
        createAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _firestore
          .collection('notes')
          .doc(note.id)
          .update(noteModel.toJson());
    } catch (e) {
      print("Failed to update note: $e");
    }
  }

  Future<void> deleteNoteById(String id) async {
    try {
      await _firestore.collection('notes').doc(id).delete();
    } catch (e) {
      print("Failed to delete note: $e");
    }
  }
}
