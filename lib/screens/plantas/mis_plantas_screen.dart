import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intelligreen_mobile/models/planta_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:intelligreen_mobile/widgets/plantas/mis_plantas_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

class MisPlantasScreen extends StatefulWidget {
  const MisPlantasScreen({super.key});

  @override
  State<MisPlantasScreen> createState() => _MisPlantasScreenState();
}

class _MisPlantasScreenState extends State<MisPlantasScreen> {
  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(microseconds: 5), () {
      completer.complete();
    });
    setState(() {});
    return completer.future.then<void>((_) {});
  }

  Future<List<PlantaUsuario>> getDispositivos() async {
    List<PlantaUsuario> plantasUsuario = [];

    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https("intelligreenapi.azurewebsites.net", "/PlantaUsuario"));

      final data = jsonDecode(response.body);

      for (dynamic item in data) {
        plantasUsuario.add(PlantaUsuario.fromJson(item));
      }
    } finally {
      client.close();
    }

    return plantasUsuario;
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Mis Plantas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder(
              future: getDispositivos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MisPlantasItem(planta: snapshot.data![index]);
                      });
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
          ),
        ],
      ),
    );
  }
}
