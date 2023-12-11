class Planta {
  final String plantaId;
  final String nombreColoquial;
  final String nombreCientifico;
  final String descripcion;
  final String imgUrl;
  final double dificultad;
  final int minHumedadAmb;
  final int maxHumedadAmb;
  final int minTempAmb;
  final int maxTempAmb;
  final int minHumedadSuelo;
  final int maxHumedadSuelo;
  final List<dynamic> cuidados;

  const Planta(
      {required this.plantaId,
      required this.nombreColoquial,
      required this.nombreCientifico,
      required this.descripcion,
      required this.imgUrl,
      required this.dificultad,
      required this.minHumedadAmb,
      required this.maxHumedadAmb,
      required this.minHumedadSuelo,
      required this.maxHumedadSuelo,
      required this.minTempAmb,
      required this.maxTempAmb,
      required this.cuidados});

  factory Planta.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'plantaId': String plantaId,
        'nombre': String nombre,
        'nombreCientifico': String nombreCientifico,
        'descripcion': String descripcion,
        'dificultad': int dificultad,
        'imgUrl': String imgUrl,
        'minHumedadAmb': int minHumedadAmb,
        'maxHumedadAmb': int maxHumedadAmb,
        'minHumedadSuelo': int minHumedadSuelo,
        'maxHumedadSuelo': int maxHumedadSuelo,
        'minTempAmb': int minTempAmb,
        'maxTempAmb': int maxTempAmb,
        'cuidados': List<dynamic> cuidados
      } =>
        Planta(
            plantaId: plantaId,
            nombreColoquial: nombre,
            nombreCientifico: nombreCientifico,
            descripcion: descripcion,
            dificultad: dificultad.toDouble(),
            imgUrl: imgUrl,
            minHumedadAmb: minHumedadAmb,
            maxHumedadAmb: maxHumedadAmb,
            minHumedadSuelo: minHumedadSuelo,
            maxHumedadSuelo: maxHumedadSuelo,
            minTempAmb: minTempAmb,
            maxTempAmb: maxTempAmb,
            cuidados: cuidados),
      _ => throw const FormatException("Planta inválida"),
    };
  }
}
