import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intelligreen_mobile/models/planta.dart';
import 'package:intelligreen_mobile/widgets/catalogo/catalogo_planta_item.dart';
import 'package:http/http.dart' as http;
import 'package:logo_n_spinner/logo_n_spinner.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  Future<List<Planta>> getPlantas() async {
    List<Planta> plantas = [];

    var client = http.Client();
    try {
      var response = await client.get(Uri.http("10.0.2.2:5212", "/Planta"));

      final data = jsonDecode(response.body);

      for (dynamic item in data) {
        plantas.add(Planta.fromJson(item));
      }
    } finally {
      client.close();
    }

    return plantas;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Catálogo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35.0,
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: getPlantas(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CatalogoPlantaItem(planta: snapshot.data![index]);
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
    );
  }
}
