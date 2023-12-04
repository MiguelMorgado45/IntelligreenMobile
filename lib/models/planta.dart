class Planta {
  final String plantaId;
  final String nombreColoquial;
  final String nombreCientifico;
  final String imgUrl;
  final double dificultad;

  const Planta(
      {required this.plantaId,
      required this.nombreColoquial,
      required this.nombreCientifico,
      required this.imgUrl,
      required this.dificultad});

  factory Planta.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'plantaId': String plantaId,
        'nombre': String nombre,
        'nombreCientifico': String nombreCientifico,
        'dificultad': int dificultad,
        'imgUrl': String imgUrl
      } =>
        Planta(
            plantaId: plantaId,
            nombreColoquial: nombre,
            nombreCientifico: nombreCientifico,
            dificultad: dificultad.toDouble(),
            imgUrl: imgUrl),
      _ => throw const FormatException("Planta inválida"),
    };
  }
}
