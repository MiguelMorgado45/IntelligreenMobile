import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intelligreen_mobile/models/dispositivo.dart';
import 'package:http/http.dart' as http;
import 'package:intelligreen_mobile/widgets/dispositivos/dispositivo_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

class DispositivosScreen extends StatefulWidget {
  const DispositivosScreen({super.key});

  @override
  State<DispositivosScreen> createState() => _DispositivosScreenState();
}

class _DispositivosScreenState extends State<DispositivosScreen> {
  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(microseconds: 5), () {
      completer.complete();
    });
    setState(() {});
    return completer.future.then<void>((_) {});
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
    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Mis Greenbox",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed("crearDispositivos",
                  extra: const Dispositivo(
                      dispositivoId: null, nombre: "", circuitoId: ""));
            },
            child: const Text("Agregar Greenbox"),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: getDispositivos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return DispositivoItem(
                            dispositivo: snapshot.data![index]);
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
