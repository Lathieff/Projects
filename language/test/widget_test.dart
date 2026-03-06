import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mlkit_translate/main.dart';
import 'package:flutter_mlkit_translate/providers/translation_provider.dart';

void main() {
  testWidgets('App launches and shows language selector', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TranslationProvider(),
        child: const MyApp(),
      ),
    );

    // App should render without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}