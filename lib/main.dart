import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const EventHubApp());
}

class EventHubApp extends StatelessWidget {
  const EventHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventHub',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
         home: const HomeScreen(),
    );
  }
}