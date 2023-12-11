import 'dart:convert';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intelligreen_mobile/models/dispositivo.dart';
import 'package:http/http.dart' as http;

class CrearDispositivosBTScreen extends StatefulWidget {
  const CrearDispositivosBTScreen({super.key, required this.dispositivo});

  final Dispositivo dispositivo;

  @override
  State<CrearDispositivosBTScreen> createState() =>
      _CrearDispositivosBTScreenState();
}

class _CrearDispositivosBTScreenState extends State<CrearDispositivosBTScreen> {
  final _bluetoothClassicPlugin = BluetoothClassic();
  List<Device> _discoveredDevices = [];
  Device? _selectedDevice;

  bool _scanning = false;
  Uint8List _data = Uint8List(0);
  String? id;

  final nombreController = TextEditingController();
  final redController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scan();
    _bluetoothClassicPlugin.onDeviceDataReceived().listen((event) {
      _data = Uint8List(0);
      if (id == null) {
        setState(() {
          _data = Uint8List.fromList([..._data, ...event]);
          id = String.fromCharCodes(_data);
        });
      }
    });
  }

  @override
  void dispose() {
    nombreController.dispose();
    redController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _scan() async {
    if (_scanning) {
      await _bluetoothClassicPlugin.stopScan();
      setState(() {
        _scanning = false;
      });
    } else {
      await _bluetoothClassicPlugin.startScan();
      _bluetoothClassicPlugin.onDeviceDiscovered().listen((event) {
        setState(() {
          _discoveredDevices = [..._discoveredDevices, event];
        });
      });
      setState(() {
        _scanning = true;
      });
    }
  }

  Future<void> crearDispositivo(Dispositivo dispositivo) async {
    var client = http.Client();
    try {
      Map datos = {
        'dispositivoId': dispositivo.dispositivoId,
        'circuitoId': dispositivo.circuitoId,
        'nombre': dispositivo.nombre
      };

      String body = json.encode(datos);

      await client.post(
          Uri.https(
              "7d3c-2806-2a0-1432-3e82-b981-a275-87e5-f6fd.ngrok-free.app",
              "/Dispositivo"),
          headers: {"Content-Type": "application/json"},
          body: body);

      // ignore: use_build_context_synchronously
      context.pushReplacementNamed("dispositivos");
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 340,
            child: SingleChildScrollView(child: renderDeviceList()),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            child: renderDeviceForm(),
          ),
          //Text("Received data: ${String.fromCharCodes(_data)}"),
        ],
      ),
    );
  }

  Widget renderDeviceForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            _selectedDevice != null
                ? (_selectedDevice!.name ?? _selectedDevice!.address)
                : "Dispositivo",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Icon(
              id != null ? Icons.check : Icons.punch_clock,
              color: id != null ? Colors.green : Colors.amber,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: nombreController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Ingresa el nombre del dispositivo",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: redController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Ingresa el nombre de tu red",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
              "No guardamos esta información, solo se utiliza para conectar Greenbox a tu red :3"),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Ingresa la contraseña de tu red",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          id != null
              ? ElevatedButton(
                  onPressed: () async {
                    await _bluetoothClassicPlugin.write(
                        "${redController.value.text.trim()}|${passwordController.value.text.trim()}");

                    await crearDispositivo(Dispositivo(
                        dispositivoId: widget.dispositivo.circuitoId,
                        nombre: nombreController.value.text,
                        circuitoId: id!));
                  },
                  child: const Text("Agregar dispositivo"),
                )
              : const Text(""),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget renderDeviceList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Dispositivos encontrados",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ...[
          for (var device in _discoveredDevices)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _selectedDevice != null && _selectedDevice == device
                        ? const Color(0xFFFFC4B0)
                        : const Color(0xFFE4BECB),
              ),
              onPressed: () async {
                await _bluetoothClassicPlugin.connect(
                    device.address, "00001101-0000-1000-8000-00805f9b34fb");
                setState(() {
                  _selectedDevice = device;
                });
                //_bluetoothClassicPlugin.write("IZZI-D66E|etpRGh6G");
              },
              child: Text(device.name ?? device.address),
            )
        ],
      ],
    );
  }
}
