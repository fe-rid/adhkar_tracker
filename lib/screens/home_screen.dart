import 'package:flutter/material.dart';
import 'today_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TodayScreen(),
    HistoryScreen(),
    // Placeholder for an actions/other page
    Center(child: Text('Actions', style: TextStyle(fontSize: 18))),
  ];

  void _onItemTapped(int idx) {
    setState(() => _selectedIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    // colors available if you want to theme the bottom bar / FAB
    // final primary = Theme.of(context).colorScheme.primary;
    // final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      body: _pages[_selectedIndex],
      // Floating action button removed as requested
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[800],
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Today'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), label: 'Actions'),
        ],
      ),
    );
  }
}
