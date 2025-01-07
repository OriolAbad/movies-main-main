import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/widgets/index_number.dart';

class TopRatedItem extends StatelessWidget {
  const TopRatedItem({
    super.key,
    required this.actor,  // Recibe el actor para mostrar en el widget.
    required this.index,  // Recibe el índice para mostrar la posición del actor.
  });

  final Actor actor; // Declaración de actor de tipo 'Actor'.
  final int index;    // Declaración de 'index' para identificar la posición del actor.

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // GestureDetector se usa para detectar el toque en el widget.
        GestureDetector(
          onTap: () => Get.to(
            DetailsScreen(actor: actor), // Navega a la pantalla de detalles del actor.
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + actor.profilePath, // Carga la imagen del actor usando la URL base y el perfil del actor.
                fit: BoxFit.cover,
                height: 250, 
                width: 180, 
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.person_off, // Si hay un error cargando la imagen, muestra este ícono.
                  size: 180,
                ),
                loadingBuilder: (_, __, ___) {
                  // Si la imagen está cargando, muestra un shimmer.
                  if (___ == null) return __; // Imagen cargada, muestra la imagen.
                  return const FadeShimmer(
                    width: 180, 
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        // Align se usa para alinear el número de índice en la parte inferior izquierda.
        Align(
          alignment: Alignment.bottomLeft,
          child: IndexNumber(number: index), // Muestra el número de índice sobre la imagen.
        )
      ],
    );
  }
}
