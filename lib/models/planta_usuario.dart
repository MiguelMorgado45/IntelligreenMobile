class PlantaUsuario {
  final String? plantaUsuarioId;
  final String? plantaId;
  final String? apodo;
  final String? dispositivoId;

  const PlantaUsuario(
      {required this.plantaUsuarioId,
      required this.plantaId,
      required this.apodo,
      required this.dispositivoId});

  factory PlantaUsuario.fromJson(Map<String, dynamic> json) {
    return PlantaUsuario(
        plantaUsuarioId: json['plantaUsuarioId'],
        plantaId: json['plantaId'],
        apodo: json['apodo'],
        dispositivoId: json['dispositivoId']);
  }
}
