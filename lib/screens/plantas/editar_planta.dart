import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intelligreen_mobile/models/dispositivo.dart';
import 'package:intelligreen_mobile/models/planta_usuario.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';
import 'package:http/http.dart' as http;

class EditarPlantaScreen extends StatefulWidget {
  const EditarPlantaScreen({super.key, required this.planta});

  final PlantaUsuario planta;

  @override
  State<EditarPlantaScreen> createState() => _EditarPlantaScreenState();
}

class _EditarPlantaScreenState extends State<EditarPlantaScreen> {
  String? dropdownValue;
  final nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nombreController.text = widget.planta.apodo!;
    dropdownValue = widget.planta.dispositivoId!;
  }

  Future<void> crearPlanta(PlantaUsuario plantaUsuario) async {
    var client = http.Client();
    try {
      Map datos = {
        'plantaUsuarioId': widget.planta.plantaUsuarioId,
        'dispositivoId': plantaUsuario.dispositivoId,
        'plantaId': plantaUsuario.plantaId,
        'apodo': plantaUsuario.apodo
      };

      String body = json.encode(datos);

      await client.post(
          Uri.https("intelligreenapi.azurewebsites.net", "/PlantaUsuario"),
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
      var response = await client
          .get(Uri.https("intelligreenapi.azurewebsites.net", "/Dispositivo"));

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
                const Text(
                  "Editar tu planta",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 80,
                  child: Image.network(widget.planta.planta!.imgUrl),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    hintText: "Nombre de la planta",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                DropdownButton(
                    value: dropdownValue,
                    hint: const Text("Selecciona el Greenbox de esta planta"),
                    items: snapshot.data!
                        .map<DropdownMenuItem<String>>((Dispositivo value) {
                      return DropdownMenuItem<String>(
                          value: value.dispositivoId,
                          child: Text(value.nombre));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    }),
                const SizedBox(
                  height: 30,
                ),
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
