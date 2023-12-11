import 'package:flutter/material.dart';
import 'package:gonote/widget/notes.dart';

var lightModeColorTheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(118, 212, 184, 0),
);

var darkModeColorTheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 21, 2, 128),
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: darkModeColorTheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: darkModeColorTheme.primaryContainer,
            foregroundColor: darkModeColorTheme.onPrimaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: darkModeColorTheme.secondaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: darkModeColorTheme.primaryContainer,
            foregroundColor: darkModeColorTheme.onPrimaryContainer,
          ))),
      theme: ThemeData().copyWith(
          colorScheme: lightModeColorTheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: lightModeColorTheme.primaryContainer,
            foregroundColor: lightModeColorTheme.onPrimaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: lightModeColorTheme.secondaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: lightModeColorTheme.primaryContainer,
            foregroundColor: lightModeColorTheme.onPrimaryContainer,
          ))),
      home: const Notes(),
    );
  }
}
