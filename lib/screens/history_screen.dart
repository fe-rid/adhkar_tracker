import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/storage_service.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final StorageService _storage = StorageService();
  Map<String, int> _history = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final h = await _storage.getAllHistory();
    setState(() {
      _history = h;
      _loading = false;
    });
  }

  String _formatDateKey(String key) {
    try {
      final dt = DateTime.parse(key);
      return DateFormat.yMMMd().format(dt);
    } catch (_) {
      return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _history.isEmpty
              ? Center(
                  child:
                      Text('No history yet. Go to Today and start counting.'))
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final key = _history.keys.elementAt(index);
                    final value = _history[key] ?? 0;
                    return ListTile(
                      leading: CircleAvatar(child: Text(value.toString())),
                      title: Text(_formatDateKey(key)),
                      subtitle: Text('Completed: $value'),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: _load,
        tooltip: 'Reload history',
      ),
    );
  }
}
