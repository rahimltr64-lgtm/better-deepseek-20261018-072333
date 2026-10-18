/// بيانات الحروف العربية الـ28 مع كلمة مثال وصورة تعبيرية.
class ArabicLetter {
  const ArabicLetter({
    required this.letter,
    required this.name,
    required this.word,
    required this.emoji,
  });

  /// شكل الحرف المفرد
  final String letter;

  /// اسم الحرف منطوقاً (ألف، باء، ...)
  final String name;

  /// كلمة تبدأ بالحرف
  final String word;

  /// رمز تعبيري يمثل الكلمة
  final String emoji;
}

const List<ArabicLetter> arabicLetters = <ArabicLetter>[
  ArabicLetter(letter: 'أ', name: 'ألف', word: 'أسد', emoji: '🦁'),
  ArabicLetter(letter: 'ب', name: 'باء', word: 'بطة', emoji: '🦆'),
  ArabicLetter(letter: 'ت', name: 'تاء', word: 'تفاحة', emoji: '🍎'),
  ArabicLetter(letter: 'ث', name: 'ثاء', word: 'ثعلب', emoji: '🦊'),
  ArabicLetter(letter: 'ج', name: 'جيم', word: 'جمل', emoji: '🐪'),
  ArabicLetter(letter: 'ح', name: 'حاء', word: 'حصان', emoji: '🐴'),
  ArabicLetter(letter: 'خ', name: 'خاء', word: 'خروف', emoji: '🐑'),
  ArabicLetter(letter: 'د', name: 'دال', word: 'دلفين', emoji: '🐬'),
  ArabicLetter(letter: 'ذ', name: 'ذال', word: 'ذئب', emoji: '🐺'),
  ArabicLetter(letter: 'ر', name: 'راء', word: 'روبوت', emoji: '🤖'),
  ArabicLetter(letter: 'ز', name: 'زاي', word: 'زرافة', emoji: '🦒'),
  ArabicLetter(letter: 'س', name: 'سين', word: 'سمكة', emoji: '🐟'),
  ArabicLetter(letter: 'ش', name: 'شين', word: 'شمس', emoji: '☀️'),
  ArabicLetter(letter: 'ص', name: 'صاد', word: 'صقر', emoji: '🦅'),
  ArabicLetter(letter: 'ض', name: 'ضاد', word: 'ضفدع', emoji: '🐸'),
  ArabicLetter(letter: 'ط', name: 'طاء', word: 'طائرة', emoji: '✈️'),
  ArabicLetter(letter: 'ظ', name: 'ظاء', word: 'ظرف', emoji: '✉️'),
  ArabicLetter(letter: 'ع', name: 'عين', word: 'عنب', emoji: '🍇'),
  ArabicLetter(letter: 'غ', name: 'غين', word: 'غزال', emoji: '🦌'),
  ArabicLetter(letter: 'ف', name: 'فاء', word: 'فيل', emoji: '🐘'),
  ArabicLetter(letter: 'ق', name: 'قاف', word: 'قمر', emoji: '🌙'),
  ArabicLetter(letter: 'ك', name: 'كاف', word: 'كتاب', emoji: '📚'),
  ArabicLetter(letter: 'ل', name: 'لام', word: 'ليمون', emoji: '🍋'),
  ArabicLetter(letter: 'م', name: 'ميم', word: 'موز', emoji: '🍌'),
  ArabicLetter(letter: 'ن', name: 'نون', word: 'نحلة', emoji: '🐝'),
  ArabicLetter(letter: 'ه', name: 'هاء', word: 'هدهد', emoji: '🐦'),
  ArabicLetter(letter: 'و', name: 'واو', word: 'وردة', emoji: '🌹'),
  ArabicLetter(letter: 'ي', name: 'ياء', word: 'يد', emoji: '✋'),
];
