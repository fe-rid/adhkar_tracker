import 'dart:convert';

class StorageService {
  static const _keyHistory = 'adhkar_history_v1';

  get SharedPreferences => null;

  // History stored as map dateString -> int count
  Future<Map<String, int>> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyHistory);
    if (raw == null) return {};
    try {
      final Map<String, dynamic> m = json.decode(raw);
      return m.map((k, v) => MapEntry(k, (v as num).toInt()));
    } catch (_) {
      return {};
    }
  }

  Future<void> _saveAll(Map<String, int> m) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = json.encode(m);
    await prefs.setString(_keyHistory, raw);
  }

  Future<int> getCountForDate(DateTime date) async {
    final m = await _loadAll();
    final key = _dateKey(date);
    return m[key] ?? 0;
  }

  Future<void> setCountForDate(DateTime date, int count) async {
    final m = await _loadAll();
    m[_dateKey(date)] = count;
    await _saveAll(m);
  }

  Future<Map<String, int>> getAllHistory() async {
    final m = await _loadAll();
    // return sorted map newest-first
    final sorted = Map.fromEntries(
        m.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));
    return sorted.map((k, v) => MapEntry(k, v));
  }

  String _dateKey(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  /// Increment today's count by 1 and return new value
  Future<int> incrementToday() async {
    final today = DateTime.now();
    final key = _dateKey(today);
    final m = await _loadAll();
    final current = m[key] ?? 0;
    final next = current + 1;
    m[key] = next;
    await _saveAll(m);
    return next;
  }

  /// Reset today's count to 0 (if needed)
  Future<void> resetToday() async {
    final today = _dateKey(DateTime.now());
    final m = await _loadAll();
    m[today] = 0;
    await _saveAll(m);
  }
}
