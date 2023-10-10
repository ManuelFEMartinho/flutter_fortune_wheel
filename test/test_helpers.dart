import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_pie_wheel.dart';
import 'package:flutter_test/flutter_test.dart';

Future pumpFortuneWidget(WidgetTester tester, PieSelector widget) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    ),
  );
}

const List<PieItem> testItems = <PieItem>[
  PieItem(child: Text('1')),
  PieItem(child: Text('2')),
];
