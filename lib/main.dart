import 'package:flutter/material.dart';
import 'package:intelligreen_mobile/router/app_navigation.dart';

void main() => runApp(const IntelligreenApp());

class IntelligreenApp extends StatefulWidget {
  const IntelligreenApp({super.key});

  @override
  State<IntelligreenApp> createState() => _IntelligreenAppState();
}

class _IntelligreenAppState extends State<IntelligreenApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Intelligreen',
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
      /*
      home: Scaffold(
        body: SafeArea(child: _screens[currentIndex]),
        bottomNavigationBar: IntelligreenBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
      */
    );
  }
}
