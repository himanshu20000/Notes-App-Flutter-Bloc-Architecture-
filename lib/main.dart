import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notes_app/bloc/notes_bloc.dart';
import 'package:notes_app/screens/DashboardScreen.dart';
import 'package:notes_app/screens/SimpleLogin.dart';
import 'package:notes_app/screens/loginScreen.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:await getTemporaryDirectory(),
  );
  runApp(MaterialApp(

    // Provide the MaterialApp with a home widget
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(
      useMaterial3: true
    ),

    home: BlocProvider<NotesBloc>(
      create:(context)=> NotesBloc()..add(
  notesStarted()
  ),
      child: DashboardScreen(),
    ),
  ));
}
