import 'package:flutter/foundation.dart';

import '../../core/data/arabic_letters.dart';
import '../../core/data/arabic_numbers.dart';
import '../../core/services/storage_service.dart';

/// يحفظ ويتابع تقدّم الطفل: الحروف والأرقام المتعلَّمة والنجوم.
class ProgressController extends ChangeNotifier {
  static const String _kLetters = 'learned_letters';
  static const String _kNumbers = 'learned_numbers';
  static const String _kStars = 'stars';
  static const String _kBestScore = 'best_quiz_score';

  final Set<String> _learnedLetters = <String>{};
  final Set<int> _learnedNumbers = <int>{};

  int _stars = 0;
  int _bestScore = 0;

  int get stars => _stars;
  int get bestScore => _bestScore;
  Set<String> get learnedLetters => Set<String>.unmodifiable(_learnedLetters);
  Set<int> get learnedNumbers => Set<int>.unmodifiable(_learnedNumbers);

  int get totalLetters => arabicLetters.length;
  int get totalNumbers => arabicNumbers.length;

  double get lettersProgress =>
      totalLetters == 0 ? 0 : _learnedLetters.length / totalLetters;

  double get numbersProgress =>
      totalNumbers == 0 ? 0 : _learnedNumbers.length / totalNumbers;

  bool isLetterLearned(String letter) => _learnedLetters.contains(letter);

  bool isNumberLearned(int value) => _learnedNumbers.contains(value);

  Future<void> load() async {
    final prefs = StorageService.instance.prefs;

    _learnedLetters
      ..clear()
      ..addAll(prefs.getStringList(_kLetters) ?? <String>[]);

    _learnedNumbers
      ..clear()
      ..addAll(
        (prefs.getStringList(_kNumbers) ?? <String>[])
            .map(int.tryParse)
            .whereType<int>(),
      );

    _stars = prefs.getInt(_kStars) ?? 0;
    _bestScore = prefs.getInt(_kBestScore) ?? 0;

    notifyListeners();
  }

  Future<void> markLetterLearned(String letter) async {
    if (!_learnedLetters.add(letter)) return;
    _stars += 2;
    await _persist();
    notifyListeners();
  }

  Future<void> markNumberLearned(int value) async {
    if (!_learnedNumbers.add(value)) return;
    _stars += 2;
    await _persist();
    notifyListeners();
  }

  Future<void> addQuizResult(int score) async {
    _stars += score;
    if (score > _bestScore) _bestScore = score;
    await _persist();
    notifyListeners();
  }

  Future<void> resetAll() async {
    _learnedLetters.clear();
    _learnedNumbers.clear();
    _stars = 0;
    _bestScore = 0;
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = StorageService.instance.prefs;
    await prefs.setStringList(_kLetters, _learnedLetters.toList());
    await prefs.setStringList(
      _kNumbers,
      _learnedNumbers.map((int value) => value.toString()).toList(),
    );
    await prefs.setInt(_kStars, _stars);
    await prefs.setInt(_kBestScore, _bestScore);
  }
}
