import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/application/note/note_bloc.dart';
import 'package:notable/domain/note/note_model.dart';
import 'package:notable/presentation/screens/add%20note%20screen/add_note_screen.dart';
import 'package:notable/presentation/utils/theme.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNoteScreen(
                    isEditMode: true,
                    noteModel: note,
                  ),
                ),
              );
            },
            child: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 2.0,
                ),
              ),
              child: Icon(
                Icons.edit,
                color: CustomColors.primaryLight,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              context.read<NoteBloc>().add(DeleteNote(note.id));
            },
            child: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 2.0,
                ),
              ),
              child: Icon(
                Icons.delete,
                color: CustomColors.primaryLight,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: CustomColors.primary.withOpacity(0.7),
      title: Text(
        note.title!,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.white, fontSize: 20),
      ),
      subtitle: Text(
        note.description!,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
