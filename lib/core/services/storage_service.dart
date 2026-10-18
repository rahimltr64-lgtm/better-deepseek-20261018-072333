import 'package:shared_preferences/shared_preferences.dart';

/// غلاف بسيط حول SharedPreferences للوصول المتزامن بعد التهيئة.
class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  late SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
