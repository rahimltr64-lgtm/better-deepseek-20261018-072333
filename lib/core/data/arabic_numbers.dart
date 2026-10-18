/// بيانات الأرقام من ٠ إلى ١٠ بالشكل العربي والهندي.
class ArabicNumber {
  const ArabicNumber({
    required this.value,
    required this.digit,
    required this.word,
  });

  /// القيمة الرقمية (0 - 10)
  final int value;

  /// الرقم بالشكل العربي الهندي (٠ ١ ٢ ...)
  final String digit;

  /// النطق اللفظي (صفر، واحد، ...)
  final String word;
}

const List<ArabicNumber> arabicNumbers = <ArabicNumber>[
  ArabicNumber(value: 0, digit: '٠', word: 'صِفر'),
  ArabicNumber(value: 1, digit: '١', word: 'واحد'),
  ArabicNumber(value: 2, digit: '٢', word: 'اثنان'),
  ArabicNumber(value: 3, digit: '٣', word: 'ثلاثة'),
  ArabicNumber(value: 4, digit: '٤', word: 'أربعة'),
  ArabicNumber(value: 5, digit: '٥', word: 'خمسة'),
  ArabicNumber(value: 6, digit: '٦', word: 'ستة'),
  ArabicNumber(value: 7, digit: '٧', word: 'سبعة'),
  ArabicNumber(value: 8, digit: '٨', word: 'ثمانية'),
  ArabicNumber(value: 9, digit: '٩', word: 'تسعة'),
  ArabicNumber(value: 10, digit: '١٠', word: 'عشرة'),
];

/// رموز تستخدم لعرض عدد الأشياء لكل رقم.
const List<String> countingEmojis = <String>[
  '🍎',
  '🐟',
  '🎈',
  '🌸',
  '🐝',
  '🍓',
  '🚗',
  '🦋',
  '⚽',
  '🍩',
  '🌟',
];
