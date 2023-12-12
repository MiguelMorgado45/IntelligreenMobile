class Estadistica {
  final String humedad;
  final String temperatura;
  final String humedadSuelo;

  const Estadistica(
      {required this.humedad,
      required this.temperatura,
      required this.humedadSuelo});

  factory Estadistica.fromJson(Map<String, dynamic> json) {
    return Estadistica(
        humedad: json["humedad"].toString(),
        humedadSuelo: json["humedadTierra"].toString(),
        temperatura: json["temperatura"].toString());
  }
}
