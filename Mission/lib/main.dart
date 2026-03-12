import 'package:flutter/material.dart';
import 'package:sales_erp/society/Commission/overview_card.dart';
import 'package:sales_erp/society/Level/level.dart';
import 'sales_erp/sales_home1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const LevelScreen(),
    );
  }

}
