import 'package:flutter/material.dart';

/// لوحة ألوان التطبيق.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF7C5CFF);
  static const Color secondary = Color(0xFFFFB020);
  static const Color success = Color(0xFF2ED573);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF17C3B2);

  static const Color lightBackground = Color(0xFFFFF8F0);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF101018);
  static const Color darkSurface = Color(0xFF1C1C28);

  /// ألوان بطاقات الحروف (تتكرر بالتناوب).
  static const List<Color> letters = <Color>[
    Color(0xFF7C5CFF),
    Color(0xFF17C3B2),
    Color(0xFFFF8C42),
    Color(0xFFFF4D8D),
    Color(0xFF3D9BFF),
    Color(0xFF9C6BFF),
  ];

  /// ألوان بطاقات الأرقام.
  static const List<Color> numbers = <Color>[
    Color(0xFF17C3B2),
    Color(0xFF7C5CFF),
    Color(0xFFFF8C42),
    Color(0xFFFF4D8D),
    Color(0xFF3D9BFF),
  ];
}
