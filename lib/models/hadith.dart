class Hadith {
  final String arabic;
  final String translation;
  final String source; // optional: source/book

  Hadith({
    required this.arabic,
    required this.translation,
    this.source = '',
  });

  factory Hadith.fromMap(Map<String, dynamic> m) {
    // try different possible keys depending on API shape
    final arabic = m['arabic'] ?? m['text'] ?? m['arabic_text'] ?? '';
    final translation =
        m['translation'] ?? m['english'] ?? m['translation_text'] ?? '';
    final source = m['book'] ?? m['source'] ?? '';

    return Hadith(arabic: arabic.toString(), translation: translation.toString(), source: source.toString());
  }
}
