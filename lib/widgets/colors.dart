import 'package:flutter/material.dart';

class MainTheme{
  Color backgroud = Color(0xFFE0F7FA);
  Color primary = Color(0xFF26C6DA);
  Color accent = Color(0xFFC5032B);
  Color fbColor = Color(0xFF26C6DA);
  Color ffColor = Color(0xFFFEEAE6);
  Color stColor = Color(0xFFFBB8AC);
  
  MainTheme(this.backgroud, this.primary, this.accent, this.fbColor, this.ffColor, this.stColor);
}

int numberOfThemes = 3;

MainTheme selectTheme(int kind){
  switch(kind){
    case 0:
      return MainTheme(
        Color(0xFFE0F7FA),
        Color(0xFF26C6DA),
        Color(0xFFC5032B),
        Color(0xFF26C6DA),
        Color(0xFFFEEAE6),
        Color(0xFFFBB8AC)
      );
    case 1:
      return MainTheme(
        Colors.lightBlue[400],
        Colors.blue[900],
        Colors.blue,
        Colors.lightBlueAccent,
        Colors.blue[100],
        Colors.teal[50]
      );
    case 2:
      return MainTheme(
        Colors.pink[50],
        Colors.blue[900],
        Colors.purple[900],
        Colors.purple[600],
        Colors.pinkAccent[700],
        Colors.pink[100]
      );
    default:
      return MainTheme(
        Color(0xFFE0F7FA),
        Color(0xFF26C6DA),
        Color(0xFFC5032B),
        Color(0xFF26C6DA),
        Color(0xFFFEEAE6),
        Color(0xFFFBB8AC)
      );
  }
}