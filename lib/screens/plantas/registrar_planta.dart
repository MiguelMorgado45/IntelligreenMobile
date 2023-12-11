import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intelligreen_mobile/models/dispositivo.dart';
import 'package:intelligreen_mobile/models/planta.dart';
import 'package:http/http.dart' as http;
import 'package:intelligreen_mobile/models/planta_usuario.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

class RegistrarPlanta extends StatefulWidget {
  const RegistrarPlanta({super.key, required this.planta});

  final Planta planta;

  @override
  State<RegistrarPlanta> createState() => _RegistrarPlantaState();
}

class _RegistrarPlantaState extends State<RegistrarPlanta> {
  String? dropdownValue;
  final nombreController = TextEditingController();

  Future<void> crearPlanta(PlantaUsuario plantaUsuario) async {
    var client = http.Client();
    try {
      Map datos = {
        'dispositivoId': plantaUsuario.dispositivoId,
        'plantaId': plantaUsuario.plantaId,
        'apodo': plantaUsuario.apodo
      };

      String body = json.encode(datos);

      await client.post(
          Uri.https(
              "7d3c-2806-2a0-1432-3e82-b981-a275-87e5-f6fd.ngrok-free.app",
              "/PlantaUsuario"),
          headers: {"Content-Type": "application/json"},
          body: body);

      // ignore: use_build_context_synchronously
      context.pushReplacementNamed("plantas");
    } finally {
      client.close();
    }
  }

  Future<List<Dispositivo>> getDispositivos() async {
    List<Dispositivo> dispositivos = [];

    var client = http.Client();
    try {
      var response = await client.get(Uri.https(
          "7d3c-2806-2a0-1432-3e82-b981-a275-87e5-f6fd.ngrok-free.app",
          "/Dispositivo"));

      final data = jsonDecode(response.body);

      for (dynamic item in data) {
        dispositivos.add(Dispositivo.fromJson(item));
      }
    } finally {
      client.close();
    }

    return dispositivos;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: getDispositivos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const Text("Registra tu planta"),
                CircleAvatar(
                  child: Image.network(widget.planta.imgUrl),
                ),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    hintText: "Nombre de la planta",
                    border: OutlineInputBorder(),
                  ),
                ),
                DropdownButton(
                    value: dropdownValue,
                    hint: const Text("Selecciona el Greenbox de esta planta"),
                    items: snapshot.data!
                        .map<DropdownMenuItem<String>>((Dispositivo value) {
                      return DropdownMenuItem<String>(
                          value: value.circuitoId, child: Text(value.nombre));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    }),
                ElevatedButton(
                    onPressed: () async {
                      await crearPlanta(PlantaUsuario(
                          plantaUsuarioId: null,
                          apodo: nombreController.value.text,
                          plantaId: widget.planta.plantaId,
                          dispositivoId: dropdownValue));
                    },
                    child: const Text("Registrar Planta"))
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(
                child: LogoandSpinner(
              imageAssets: "assets/logo.png",
              reverse: true,
              arcColor: Colors.green,
              spinSpeed: Duration(milliseconds: 800),
            ));
          }
        },
      ),
    );
  }
}
