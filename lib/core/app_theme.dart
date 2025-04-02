import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(255, 17, 212, 212);

const List<Color> _colorThemes = [
  _customColor,  //_colorTheme[0]
  Colors.blue,  
  Colors.teal,  // [2]
  Colors.green,
  Colors.yellow,  //[4]
  Colors.orange,
  Colors.red,
  Colors.purple,  //[7]

];

class AppTheme {
  final int selectedColor;

  AppTheme({
    this.selectedColor = 0
  }) : assert(selectedColor >= 0 && selectedColor <= _colorThemes.length - 1,
          'Colors must between 0 and ${_colorThemes.length}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor]
    );
  }
  
}