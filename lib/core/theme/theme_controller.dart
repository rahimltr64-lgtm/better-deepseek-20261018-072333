import 'package:flutter/material.dart';

import '../services/storage_service.dart';

/// يتحكم في الوضع الفاتح/الداكن ويحفظه محلياً.
class ThemeController extends ChangeNotifier {
  static const String _key = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> load() async {
    final String stored =
        StorageService.instance.prefs.getString(_key) ?? 'light';
    switch (stored) {
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'system':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    await StorageService.instance.prefs.setString(_key, mode.name);
  }
}
