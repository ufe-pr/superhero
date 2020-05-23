import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superhero/providers/theme_provider.dart';
import 'ui/characters_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

instantiate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? true;
}

void main() {
  runApp(
    FutureBuilder(
      future: Future.delayed(Duration(seconds: 1), () => instantiate()),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider(
            create: (_) => ThemeProvider(_, isDarkTheme: snapshot.data),
            child: SuperheroApp(),
          );
        }

        return SplashScreen();
      },
    ),
  );
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Supad',
        style: GoogleFonts.montserrat().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SuperheroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: Characters(),
      theme: themeProvider.themeData,
      title: 'SupaD',
    );
  }
}
