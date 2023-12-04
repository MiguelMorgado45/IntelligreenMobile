import 'package:flutter/material.dart';
import 'package:intelligreen_mobile/screens/catalogo/catalogo_screen.dart';
import 'package:intelligreen_mobile/screens/plantas/mis_plantas_screen.dart';
import 'package:intelligreen_mobile/widgets/shared/intelligreen_bottom_navigation_bar.dart';

void main() => runApp(const IntelligreenApp());

class IntelligreenApp extends StatefulWidget {
  const IntelligreenApp({super.key});

  @override
  State<IntelligreenApp> createState() => _IntelligreenAppState();
}

class _IntelligreenAppState extends State<IntelligreenApp> {
  int currentIndex = 0;

  final _screens = [
    const MisPlantasScreen(),
    const CatalogoScreen(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });

    print(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intelligreen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(child: _screens[currentIndex]),
        bottomNavigationBar: IntelligreenBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}
