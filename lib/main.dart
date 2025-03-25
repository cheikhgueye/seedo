import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seddoapp/bloc/auth/auth_bloc.dart';
import 'package:seddoapp/pages/auth/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(), // Create your AuthBloc here
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SEDDO APP',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'Poppins'),
            displayMedium: TextStyle(fontFamily: 'Poppins'),
            displaySmall: TextStyle(fontFamily: 'Poppins'),
            headlineLarge: TextStyle(fontFamily: 'Poppins'),
            headlineMedium: TextStyle(fontFamily: 'Poppins'),
            headlineSmall: TextStyle(fontFamily: 'Poppins'),
            titleLarge: TextStyle(fontFamily: 'Poppins'),
            titleMedium: TextStyle(fontFamily: 'Poppins'),
            titleSmall: TextStyle(fontFamily: 'Poppins'),
            bodyLarge: TextStyle(fontFamily: 'Poppins'),
            bodyMedium: TextStyle(fontFamily: 'Poppins'),
            bodySmall: TextStyle(fontFamily: 'Poppins'),
            labelLarge: TextStyle(fontFamily: 'Poppins'),
            labelMedium: TextStyle(fontFamily: 'Poppins'),
            labelSmall: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        home: LogIn(),
      ),
    );
  }
}
