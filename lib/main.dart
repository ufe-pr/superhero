import 'package:flutter/material.dart';
import 'ui/characters_page.dart';
import 'ui/details_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: Characters(),
      theme: ThemeData.dark(),
      routes: {
        '/home': (BuildContext context) => Characters(),
        '/details': (BuildContext context) => Details(),
      },
    ),
  );
}
