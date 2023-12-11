import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intelligreen_mobile/models/planta.dart';

class DetalleScreen extends StatelessWidget {
  final Planta planta;

  const DetalleScreen({super.key, required this.planta});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEFE0E5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              planta.nombreColoquial,
              style: const TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    planta.nombreCientifico,
                    style: const TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.network(
              planta.imgUrl,
              height: 250,
              width: 250,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    planta.descripcion,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NecesidadAvatar(
                          icono: const Icon(Icons.sunny),
                          texto:
                              "${planta.minTempAmb}°C - ${planta.maxTempAmb}°C",
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        NecesidadAvatar(
                          icono: const Icon(Icons.water),
                          texto:
                              "${planta.minHumedadAmb}% - ${planta.maxHumedadAmb}%",
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        NecesidadAvatar(
                          icono: Image.asset("assets/icono_tierra.png"),
                          texto:
                              "${planta.minHumedadSuelo}% - ${planta.maxHumedadSuelo}%",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Cuidados",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    itemCount: planta.cuidados.length,
                    itemBuilder: (context, index) {
                      return Text("- ${planta.cuidados[index].toString()}");
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Color(0xFFE4BECB),
                ),
              ),
              onPressed: () {
                context.goNamed("crear", extra: planta);
              },
              child: const Text(
                "Registrar planta",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class NecesidadAvatar extends StatelessWidget {
  final Widget icono;
  final String texto;

  const NecesidadAvatar({super.key, required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFFFFE787),
          child: icono,
        ),
        Text(texto)
      ],
    );
  }
}
