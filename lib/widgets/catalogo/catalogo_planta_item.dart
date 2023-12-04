import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intelligreen_mobile/models/planta.dart';

class CatalogoPlantaItem extends StatelessWidget {
  final Planta planta;

  const CatalogoPlantaItem({super.key, required this.planta});

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Color(0xFFF9F9F9),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ]);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  _Imagen(planta.imgUrl),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _Textos(
                    planta.nombreColoquial,
                    planta.nombreCientifico,
                  )),
                  const SizedBox(width: 12),
                  RatingAvatar(
                    dificultad: planta.dificultad,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _Imagen extends StatelessWidget {
  final String imgUrl;
  const _Imagen(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(
        imgUrl,
        width: 75.0,
        height: 75.0,
      ),
    );
  }
}

class _Textos extends StatelessWidget {
  final String nombreColoquial;
  final String nombreCientifico;
  const _Textos(this.nombreColoquial, this.nombreCientifico);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nombreColoquial,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          nombreCientifico,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}

class RatingAvatar extends StatelessWidget {
  final double dificultad;
  const RatingAvatar({super.key, required this.dificultad});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF56C300),
      radius: 25.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBar.builder(
              initialRating: dificultad,
              itemCount: 3,
              ignoreGestures: true,
              itemSize: 10.0,
              itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
              onRatingUpdate: (rating) {}),
          Text(
            dificultad == 1
                ? "Fácil"
                : dificultad == 2
                    ? "Media"
                    : "Difícil",
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
