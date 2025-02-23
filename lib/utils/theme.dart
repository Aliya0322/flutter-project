import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      fontFamily: 'Arkhip',
      primarySwatch: Colors.indigo,
      
      // Цвет фона Scaffold
      scaffoldBackgroundColor: Colors.grey[50],
      
      // Цвет фона AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      
      // Цвета для FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      
      // Цвета для текста
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
      
      // Цвета для карточек
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Цвета для кнопок
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.indigo,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      
      // Цвета для полей ввода
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // Цвета для иконок
      iconTheme: IconThemeData(
        color: Colors.indigo,
      ),
      
      // Цвета для диалогов
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}