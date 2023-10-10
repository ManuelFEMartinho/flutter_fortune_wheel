import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Pie Wheel Demo'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            GoRouterState.of(context).name == PieWheelPage.kRouteName ? 0 : 1,
        onTap: (index) {
          switch (index) {
            case 0:
              PieWheelPage.go(context);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Wheel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.linear_scale),
            label: 'Bar',
          ),
        ],
      ),
      body: child,
    );
  }
}
