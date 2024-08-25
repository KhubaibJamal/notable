import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/application/note/note_bloc.dart';
import 'package:notable/domain/note/note_model.dart';
import 'package:notable/presentation/screens/add%20note%20screen/add_note_screen.dart';
import 'package:notable/presentation/screens/home/widget/note_tile.dart';
import 'package:notable/presentation/utils/theme.dart';
import 'package:notable/presentation/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  List<NoteModel> filterNotes = [];

  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(LoadNotes());
    searchController.addListener(_filterNotes);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterNotes);
    searchController.dispose();
    super.dispose();
  }

  void _filterNotes() {
    final query = searchController.text;
    setState(() {
      filterNotes = filterNoteList(filterNotes, query);
    });
  }

  List<NoteModel> filterNoteList(List<NoteModel> note, String query) {
    if (query.isEmpty) {
      return note;
    }

    final String lowercaseQuery = query.toLowerCase();
    return note.where((note) {
      final String lowercaseName = note.title!.toLowerCase();
      return lowercaseName.contains(lowercaseQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notable",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(isEditMode: false),
            ),
          );
        },
        child: Center(
          child: Icon(
            Icons.add,
            color: CustomColors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextField(
              suffix: searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        context.read<NoteBloc>().add(LoadNotes());
                      },
                      icon: Icon(
                        Icons.close,
                        color: CustomColors.primary,
                      ),
                    )
                  : null,
              prefix: Icon(
                Icons.search,
                color: CustomColors.primary,
              ),
              readOnly: false,
              controller: searchController,
              hintText: 'Search',
              enabled: true,
              onChanged: (query) {
                context.read<NoteBloc>().add(SearchNotes(query));
              },
            ),
            SizedBox(height: height * 0.01),
            BlocBuilder<NoteBloc, NoteState>(
              builder: (noteContext, noteState) {
                if (noteState is NoteLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: noteState.notes.length,
                      itemBuilder: (context, index) {
                        final note = noteState.notes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(child: NoteTile(note: note)),
                        );
                      },
                    ),
                  );
                } else if (noteState is NoteLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text("No Notes Available"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
