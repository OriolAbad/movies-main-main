import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen.dart';

class TabBuilder extends StatelessWidget {
  const TabBuilder({
    required this.future, // Recibe un Future que devuelve una lista de actores
    super.key,
  });
  final Future<List<Actor>?> future; // Variable para almacenar el Future que obtendrá la lista de actores
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0), 
      child: FutureBuilder<List<Actor>?>( 
        future: future, // Se ejecuta el Future para obtener los actores
        builder: (context, snapshot) {
          if (snapshot.hasData) { // Si los datos se han cargado correctamente
            return GridView.builder(
              physics: const ScrollPhysics(), // Permite que el GridView sea desplazable
              shrinkWrap: false, // Permite que el GridView use el espacio disponible
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de columnas en la cuadrícula
                crossAxisSpacing: 15.0, 
                mainAxisSpacing: 15.0, 
                childAspectRatio: 0.6, 
              ),
              itemCount: snapshot.data!.length, // Número total de elementos a mostrar
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // Al tocar una imagen, navega a la pantalla de detalles del actor
                  Get.to(DetailsScreen(actor: snapshot.data![index]));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16), 
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${snapshot.data![index].profilePath}', // Carga la imagen del actor
                    height: 300,
                    width: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      // En caso de que no haya imagen, mostramos un icono
                      return const Icon(
                        Icons.person_off, // Icono que indica "sin imagen disponible"
                        size: 180,
                        color: Colors.grey, // Color del icono
                      );
                    },
                    loadingBuilder: (_, __, ___) {
                      // Muestra un efecto de carga mientras se obtiene la imagen
                      if (___ == null) return __;
                      return const FadeShimmer(
                        width: 180,
                        height: 250, 
                        highlightColor: Color(0xff20252d), 
                        baseColor: Color(0xff20252d),
                      );
                    },
                  ),
                ),
              ),
            );
          } else { // Si aún no hay datos, muestra un indicador de carga
            return const Center(
              child: CircularProgressIndicator(), // Círculo de carga mientras se obtienen los datos
            );
          }
        },
      ),
    );
  }
}
