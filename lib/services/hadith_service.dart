import 'dart:convert';
import '../models/hadith.dart';

class HadithService {
  // Default: use Fawaz Ahmed hadith collection (Bukhari) and pick a random hadith
  static const _bukhariUrl =
      'https://raw.githubusercontent.com/fawazahmed0/hadith-api/1/collections/bukhari.json';

  get http => null;

  // You can change endpoint or add other endpoints (sunnah.com wrappers, hadithhub, etc.)
  Future<Hadith> fetchRandomHadith() async {
    try {
      final res = await http.get(Uri.parse(_bukhariUrl));
      if (res.statusCode == 200) {
        final decoded = json.decode(res.body);
        // The GitHub JSON might be structured as a list or map. Adjust defensively.
        if (decoded is Map && decoded.containsKey('bukhari')) {
          final list = decoded['bukhari'] as List;
          final item = (list..shuffle()).first;
          final arabic = item['arabic'] ?? item['body'] ?? '';
          final translation = item['translation'] ?? item['english'] ?? item['id'] ?? '';
          return Hadith(arabic: arabic.toString(), translation: translation.toString());
        } else if (decoded is List) {
          final item = (decoded..shuffle()).first;
          return Hadith.fromMap(item);
        } else if (decoded is Map) {
          // try to find any nested list
          for (final v in decoded.values) {
            if (v is List && v.isNotEmpty) {
              final item = (v..shuffle()).first;
              return Hadith.fromMap(item);
            }
          }
        }
      }
    } catch (_) {
      // ignore and fallback to local
    }

    // Fallback: local sample
    return Hadith(
      arabic: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
      translation: 'Actions are judged by intentions.',
      source: 'fallback',
    );
  }
}
