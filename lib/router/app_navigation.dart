import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intelligreen_mobile/screens/catalogo/catalogo_screen.dart';
import 'package:intelligreen_mobile/screens/catalogo/detalle_screen.dart';
import 'package:intelligreen_mobile/screens/layout/main_layout.dart';
import 'package:intelligreen_mobile/screens/plantas/mis_plantas_screen.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/catalogo';

  /// Private Navigator Key
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorCatalogo =
      GlobalKey<NavigatorState>(debugLabel: "shellCatalogo");

  /// Go Router Configuration
  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: _rootNavigatorKey,
    routes: [
      // Catálogo
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainLayout(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _rootNavigatorCatalogo,
              routes: [
                GoRoute(
                    path: '/catalogo',
                    name: "catalogo",
                    builder: (context, state) => const CatalogoScreen(),
                    routes: [
                      GoRoute(
                          path: 'detalles',
                          name: 'detalles',
                          builder: (context, state) => const DetalleScreen())
                    ]),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: "/plantas",
                  name: "plantas",
                  builder: (context, state) {
                    return const MisPlantasScreen();
                  })
            ])
          ])
    ],
  );
}
