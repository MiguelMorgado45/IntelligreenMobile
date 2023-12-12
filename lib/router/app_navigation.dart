import 'package:go_router/go_router.dart';
import 'package:intelligreen_mobile/models/dispositivo.dart';
import 'package:intelligreen_mobile/models/planta.dart';
import 'package:intelligreen_mobile/models/planta_usuario.dart';
import 'package:intelligreen_mobile/screens/catalogo/catalogo_screen.dart';
import 'package:intelligreen_mobile/screens/catalogo/detalle_screen.dart';
import 'package:intelligreen_mobile/screens/dispositivos/crear_dispositivos_bt_screen.dart';
import 'package:intelligreen_mobile/screens/dispositivos/dispositivo_screen.dart';
import 'package:intelligreen_mobile/screens/layout/main_layout.dart';
import 'package:intelligreen_mobile/screens/plantas/editar_planta.dart';
import 'package:intelligreen_mobile/screens/plantas/estadisticas_screen.dart';
import 'package:intelligreen_mobile/screens/plantas/mis_plantas_screen.dart';
import 'package:intelligreen_mobile/screens/plantas/registrar_planta.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/catalogo';

  /// Go Router Configuration
  static final GoRouter router = GoRouter(
    initialLocation: initR,
    routes: [
      // Catálogo
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainLayout(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/catalogo',
                    name: "catalogo",
                    builder: (context, state) => const CatalogoScreen(),
                    routes: [
                      GoRoute(
                          path: 'detalles',
                          name: 'detalles',
                          builder: (context, state) => DetalleScreen(
                                planta: (state.extra as Planta),
                              )),
                      GoRoute(
                        path: "crear",
                        name: "crear",
                        builder: (context, state) {
                          return RegistrarPlanta(planta: state.extra as Planta);
                        },
                      ),
                      GoRoute(
                        path: "editar",
                        name: "editar",
                        builder: (context, state) {
                          return EditarPlantaScreen(
                              planta: state.extra as PlantaUsuario);
                        },
                      )
                    ]),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: "/dispositivos",
                  name: "dispositivos",
                  builder: (context, state) {
                    return const DispositivosScreen();
                  },
                  routes: [
                    GoRoute(
                        path: "crearDispositivos",
                        name: "crearDispositivos",
                        builder: (context, state) {
                          return CrearDispositivosBTScreen(
                            dispositivo: (state.extra as Dispositivo),
                          );
                        }),
                  ]),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: "/plantas",
                  name: "plantas",
                  builder: (context, state) {
                    return const MisPlantasScreen();
                  },
                  routes: [
                    GoRoute(
                        path: "estadistica",
                        name: "estadistica",
                        builder: (context, state) {
                          return EstadisticasScreen(
                            plantaUsuario: (state.extra as PlantaUsuario),
                          );
                        }),
                  ]),
            ]),
          ])
    ],
  );
}
