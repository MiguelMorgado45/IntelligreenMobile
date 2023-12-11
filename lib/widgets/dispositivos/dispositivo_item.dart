import 'package:flutter/material.dart';
import 'package:intelligreen_mobile/models/dispositivo.dart';

class DispositivoItem extends StatelessWidget {
  final Dispositivo dispositivo;

  const DispositivoItem({super.key, required this.dispositivo});

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
                  Text(dispositivo.nombre),
                  const SizedBox(width: 12),
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
