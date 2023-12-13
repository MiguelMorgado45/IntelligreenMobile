import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intelligreen_mobile/models/estadistica.dart';
import 'package:intelligreen_mobile/models/planta_usuario.dart';
import 'package:intelligreen_mobile/mqtt/mqtt_manager.dart';

class EstadisticasScreen extends StatefulWidget {
  final PlantaUsuario plantaUsuario;

  const EstadisticasScreen({super.key, required this.plantaUsuario});

  @override
  State<EstadisticasScreen> createState() => _EstadisticasScreenState();
}

class _EstadisticasScreenState extends State<EstadisticasScreen> {
  late MQTTManager manager;
  Estadistica estadistica = const Estadistica(
      humedad: "0.0", temperatura: "0.0", humedadSuelo: "0.0");

  @override
  void dispose() {
    _disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _configureAndConnect();
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        children: [
          Text(
            widget.plantaUsuario.apodo!,
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.plantaUsuario.planta!.nombreColoquial,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              widget.plantaUsuario.planta!.imgUrl,
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              )
            ]),
            child: Column(
              children: [
                humedadBox(),
                const SizedBox(
                  height: 15,
                ),
                humedadSueloBox(),
                const SizedBox(
                  height: 15,
                ),
                temperaturaBox(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget humedadBox() {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color(0xFF065996),
          ),
          padding: const EdgeInsets.all(10),
          height: 60,
          width: 60,
          child: SvgPicture.asset(
            "assets/icono_humedad.svg",
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Humedad (${widget.plantaUsuario.planta!.minHumedadAmb}% - ${widget.plantaUsuario.planta!.maxHumedadAmb}%)",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${estadistica.humedad.toString()}%",
              style: TextStyle(fontSize: 20, color: getColor(1)),
            ),
          ],
        ),
      ],
    );
  }

  Widget humedadSueloBox() {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color(0xFF965C06),
          ),
          padding: const EdgeInsets.all(10),
          height: 60,
          width: 60,
          child: SvgPicture.asset(
            "assets/icono_humedad_tierra.svg",
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Humedad de la tierra (${widget.plantaUsuario.planta!.minHumedadSuelo}% - ${widget.plantaUsuario.planta!.maxHumedadSuelo}%)",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${estadistica.humedadSuelo.toString()}%",
              style: TextStyle(fontSize: 20, color: getColor(2)),
            ),
          ],
        ),
      ],
    );
  }

  Widget temperaturaBox() {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color(0xFFCD0909),
          ),
          padding: const EdgeInsets.all(10),
          height: 60,
          width: 60,
          child: SvgPicture.asset(
            "assets/icono_temperatura.svg",
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Temperatura (${widget.plantaUsuario.planta!.minTempAmb}°C - ${widget.plantaUsuario.planta!.maxTempAmb}°C)",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${double.parse(estadistica.temperatura).toStringAsFixed(2)} °C",
              style: TextStyle(fontSize: 20, color: getColor(3)),
            ),
          ],
        ),
      ],
    );
  }

  Color? getColor(int index) {
    const peligro = Color(0xFFFF6961);
    const aceptable = Color(0xFF7ABD7E);

    switch (index) {
      case 1:
        if (double.parse(estadistica.humedad) <
                widget.plantaUsuario.planta!.minHumedadAmb ||
            double.parse(estadistica.humedad) >
                widget.plantaUsuario.planta!.maxHumedadAmb) {
          return peligro;
        } else {
          return aceptable;
        }
      case 2:
        if (double.parse(estadistica.humedadSuelo) <
                widget.plantaUsuario.planta!.minHumedadSuelo ||
            double.parse(estadistica.humedadSuelo) >
                widget.plantaUsuario.planta!.maxHumedadSuelo) {
          return peligro;
        } else {
          return aceptable;
        }
      case 3:
        if (double.parse(estadistica.temperatura) <
                widget.plantaUsuario.planta!.minTempAmb ||
            double.parse(estadistica.temperatura) >
                widget.plantaUsuario.planta!.maxTempAmb) {
          return peligro;
        } else {
          return aceptable;
        }
    }

    return null;
  }

  void setReceivedEstadistica(String json) {
    setState(() {
      var estad = Estadistica.fromJson(jsonDecode(json));
      estadistica = estad;
    });
  }

  void _configureAndConnect() {
    // ignore: flutter_style_todos
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    manager = MQTTManager(
        host: "x2824759.ala.us-east-1.emqxsl.com",
        topic: "esp32/${widget.plantaUsuario.dispositivo!.circuitoId}",
        setReceivedEstadistica: setReceivedEstadistica);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }
}
