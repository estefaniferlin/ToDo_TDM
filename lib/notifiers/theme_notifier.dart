import 'package:flutter/material.dart';
import 'package:projeto1/theme/app_theme.dart';

// Classe que gerencia o tema. Notifique os Widgets de uma mudança
class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDarkTheme;

  ThemeNotifier(this._currentTheme, this._isDarkTheme);

  getTheme() => _currentTheme;
  bool get isDarkTheme => _isDarkTheme;

  toggleTheme() {
    if (_isDarkTheme) {
      _currentTheme = AppTheme.lightTheme;
      _isDarkTheme = false;
    } else {
      _currentTheme = AppTheme.darkTheme;
      _isDarkTheme = true;
    }
    notifyListeners();
  }
}

