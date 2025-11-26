import 'package:flutter/material.dart';
import '../services/hadith_service.dart';
import '../services/storage_service.dart';
import '../models/hadith.dart';
import '../widgets/adhkar_card.dart';

class TodayScreen extends StatefulWidget {
  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final HadithService _hadithService = HadithService();
  final StorageService _storage = StorageService();

  Hadith? _hadith;
  bool _loading = true;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    setState(() => _loading = true);
    final h = await _hadithService.fetchRandomHadith();
    final c = await _storage.getCountForDate(DateTime.now());
    setState(() {
      _hadith = h;
      _count = c;
      _loading = false;
    });
  }

  Future<void> _onCountChanged(int newCount) async {
    setState(() => _count = newCount);
    await _storage.setCountForDate(DateTime.now(), newCount);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text('Today', style: titleStyle),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _initialize,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 22),
          child: Column(
            children: [
              if (_hadith != null)
                AdhkarCard(
                  arabic: _hadith!.arabic,
                  translation: _hadith!.translation,
                  initialCount: _count,
                  onCountChanged: (val) => _onCountChanged(val),
                ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.refresh),
                        label: Text('Reset Today'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {
                          await _storage.resetToday();
                          final c = await _storage.getCountForDate(DateTime.now());
                          setState(() => _count = c);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text('Tip: Pull to refresh hadith', style: TextStyle(color: Colors.grey[600]))
            ],
          ),
        ),
      ),
    );
  }
}
