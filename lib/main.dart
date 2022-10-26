import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/plants_bloc.dart';
import 'screens/home.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => PlantsBloc(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: const Home(),
        theme: ThemeData(
          // brightness: Brightness.dark,

          // inputDecorationTheme: InputDecorationTheme(focusColor: Colors.grey),
          // primaryColor: Colors.grey.shade600,
          scaffoldBackgroundColor: Colors.grey.shade300,
        ));
  }
}
