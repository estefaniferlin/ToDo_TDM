import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.green,
      colorScheme: ColorScheme.light(
        primary: Colors.green, // Cor primária
        secondary: Colors.greenAccent, // Usado para elementos de destaque como o FloatingActionButton
      ),
      appBarTheme: AppBarTheme(
        color: Colors.green,
        elevation: 4,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 26), // Define a cor do título para branco e o tamanho da fonte
        centerTitle: true, // Centraliza o título
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green), // Cor de fundo
          foregroundColor: MaterialStateProperty.all(Colors.black), // Cor do texto
          shape: MaterialStateProperty.all<RoundedRectangleBorder>( // Forma do botão
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Borda arredondada
            ),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: Colors.deepPurple, // Cor primária
        secondary: Colors.deepPurpleAccent, // Usado para elementos de destaque como o FloatingActionButton
        surface: Colors.grey[850]!,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.deepPurple[800],
        elevation: 4,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 26), // Define a cor do título para branco e o tamanho da fonte
        centerTitle: true, // Centraliza o título
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurple[700]), // Cor de fundo
          foregroundColor: MaterialStateProperty.all(Colors.white), // Cor do texto
          shape: MaterialStateProperty.all<RoundedRectangleBorder>( // Forma do botão
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Borda arredondada
            ),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[850]!, // Fundo da barra de navegação
        selectedItemColor: Colors.deepPurpleAccent, // Cor do item selecionado
        unselectedItemColor: Colors.grey[700], // Cor do item não selecionado para tema escuro
      ),
    );
  }
}
