import 'package:flutter/material.dart';

class PressureDiaryApp extends StatelessWidget {
  const PressureDiaryApp({super.key});

  static const _title = 'Дневник давления';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const Scaffold(body: Center(child: Text(_title))),
    );
  }
}
