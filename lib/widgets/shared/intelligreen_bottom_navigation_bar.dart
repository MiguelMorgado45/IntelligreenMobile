import 'package:flutter/material.dart';

class IntelligreenBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const IntelligreenBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      child: BottomNavigationBarTheme(
        data: const BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(color: Color(0xFF1A9606)),
          unselectedLabelStyle: TextStyle(color: Color(0xFF1A9606)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFDEFFB4),
          items: [
            BottomNavigationBarItem(
              icon: BottomCircleAvatar(
                image: Image.asset("assets/imagen_plantas.png"),
              ),
              label: "Plantas",
            ),
            BottomNavigationBarItem(
              icon: BottomCircleAvatar(
                image: Image.asset("assets/imagen_catalogo.png"),
              ),
              label: "Catálogo",
            )
          ],
          onTap: onTap,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}

class BottomCircleAvatar extends StatelessWidget {
  final Widget image;

  const BottomCircleAvatar({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF87D623),
      child: image,
    );
  }
}
