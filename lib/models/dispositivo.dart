class Dispositivo {
  final String? dispositivoId;
  final String nombre;
  final String circuitoId;

  const Dispositivo(
      {required this.dispositivoId,
      required this.nombre,
      required this.circuitoId});

  factory Dispositivo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "dispositivoId": String dispositivoId,
        "nombre": String nombre,
        "circuitoId": String circuitoId
      } =>
        Dispositivo(
            dispositivoId: dispositivoId,
            nombre: nombre,
            circuitoId: circuitoId),
      _ => throw const FormatException("Planta inválida"),
    };
  }
}
