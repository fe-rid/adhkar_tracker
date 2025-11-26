import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CardTheme Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // This Card uses the CardTheme (no shape/elevation set here)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('This card uses CardTheme settings'),
            ),
          ),
          // This Card overrides the theme (will NOT use CardTheme shape/elevation)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 1,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('This card overrides the theme'),
            ),
          ),
        ],
      ),
    );
  }
}
