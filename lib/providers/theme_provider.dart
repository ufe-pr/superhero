import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier {
  bool isDarkTheme;
  BuildContext context;
  final ThemeData lightTheme, darkTheme;


  ThemeProvider(this.context, {this.isDarkTheme: true})
      : lightTheme = ThemeData(
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          brightness: Brightness.light,
          inputDecorationTheme: InputDecorationTheme(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(18.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.black54),
            fillColor: Color(0xffefecec),
            contentPadding: const EdgeInsets.only(left: 20),
          ),
        ),
        darkTheme = ThemeData(
          brightness: Brightness.dark,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
          inputDecorationTheme: InputDecorationTheme(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(18.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.white60),
            fillColor: Color(0xff4f4c4c),
            contentPadding: const EdgeInsets.only(left: 20),
          ),
        );

  ThemeData get themeData => isDarkTheme ? darkTheme : lightTheme;

  themeDataSwitch(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', val);
    isDarkTheme = val;
    notifyListeners();
  }
}
