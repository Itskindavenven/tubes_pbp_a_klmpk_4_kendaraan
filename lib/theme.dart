import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.amber,
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  colorScheme: const ColorScheme.dark(
    primary: Colors.indigo,
    secondary: Colors.purpleAccent,
  ),
  brightness: Brightness.dark,
);

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
