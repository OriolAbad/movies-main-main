import 'package:flutter/material.dart';

class IndexNumber extends StatelessWidget {
  const IndexNumber({
    super.key,
    required this.number, // Número que se pasa como parámetro
  });
  final int number;

  @override
  Widget build(BuildContext context) {
    return Text(
      (number).toString(), // Convierte el número a texto
      style: const TextStyle(
        fontSize: 120, // Tamaño de la fuente del número
        fontWeight: FontWeight.w600, // Peso de la fuente (negrita)
        shadows: [
          // Sombra para el texto en varias direcciones para un efecto 3D
          Shadow(
            offset: Offset(-1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(-1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
        ],
        color: Color(0xFF242A32), // Color del texto (número)
      ),
    );
  }
}
