import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notable/application/note/note_bloc.dart';
import 'package:notable/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/presentation/screens/home/home.dart';
import 'package:notable/presentation/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(create: (BuildContext context) => NoteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notable',
        theme: lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
