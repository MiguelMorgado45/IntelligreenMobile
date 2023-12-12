import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intelligreen_mobile/models/planta.dart';
import 'package:intelligreen_mobile/widgets/catalogo/catalogo_planta_item.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(microseconds: 5), () {
      completer.complete();
    });
    setState(() {});
    return completer.future.then<void>((_) {});
  }

  Future<List<Planta>> getPlantas() async {
    List<Planta> plantas = [];

    var client = http.Client();
    try {
      var response = await client
          .get(Uri.https("intelligreenapi.azurewebsites.net", "/Planta"));

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
    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      showChildOpacityTransition: false,
      child: Column(
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
                        return CatalogoPlantaItem(
                            planta: snapshot.data![index]);
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
