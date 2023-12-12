import 'package:intelligreen_mobile/models/dispositivo.dart';
import 'package:intelligreen_mobile/models/planta.dart';

class PlantaUsuario {
  final String? plantaUsuarioId;
  final String? plantaId;
  final String? apodo;
  final String? dispositivoId;
  final Planta? planta;
  final Dispositivo? dispositivo;

  const PlantaUsuario(
      {required this.plantaUsuarioId,
      required this.plantaId,
      required this.apodo,
      required this.dispositivoId,
      this.planta,
      this.dispositivo});

  factory PlantaUsuario.fromJson(Map<String, dynamic> json) {
    return PlantaUsuario(
        plantaUsuarioId: json['plantaUsuarioId'],
        plantaId: json['plantaId'],
        apodo: json['apodo'],
        dispositivoId: json['dispositivoId'],
        planta: Planta.fromJson(json['planta']),
        dispositivo: Dispositivo.fromJson(json['dispositivo']));
  }
}
