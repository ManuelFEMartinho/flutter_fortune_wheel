import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_pie_wheel.dart';

import 'common/common.dart';
import 'router.dart';
import 'util/configure_non_web.dart'
    if (dart.library.html) 'util/configure_web.dart';
import 'widgets/widgets.dart';

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pie Wheel Example',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = <String>[
      'Grogu',
      'Mace Windu',
      'Obi-Wan Kenobi',
      'Han Solo',
      'Luke Skywalker',
      'Darth Vader',
      'Yoda',
      'Ahsoka Tano',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Pie Wheel'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected.add(2);
          });
        },
        child: Column(
          children: [
            Expanded(
              child: PieSelector(
                hapticImpact: HapticImpact.heavy,
                physics: DirectionalPanPhysics.horizontal(),
                selected: selected.stream,
                onAnimationEnd: () {
                  print('End');
                },
                items: [
                  for (var it in items)
                    TransformedPieItem(
                      offset: Offset(0, 50),
                      item: PieItem(
                        child: Text('$it lhio ${items.indexOf(it)}'),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  configureApp();
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeModeScope(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'Pie Wheel Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
