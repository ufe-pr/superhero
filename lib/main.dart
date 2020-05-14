import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ui/characters_page.dart';
import 'ui/details_page.dart';

void main() {
  runApp(
    SuperheroApp(),
  );
}

class SuperheroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Characters(),
      theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
          brightness: Brightness.dark
      ),
      routes: {
        '/home': (BuildContext context) => Characters(),
        '/details': (BuildContext context) => Details(),
      },
    );
  }
}

