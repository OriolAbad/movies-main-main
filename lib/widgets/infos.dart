import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/descactor.dart';
import 'package:movies/api/api_service.dart';

class Infos extends StatelessWidget {
  const Infos({super.key, required this.actor}); // Recibe un actor como parámetro
  final Actor actor; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Mantén la altura fija si es esencial
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Text(
              actor.name, // Muestra el nombre del actor
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis, // Limita el título a una línea
              maxLines: 1, // Máximo 1 línea
            ),
          ),
          // Detalles (POPULARIDAD, GÉNERO, ETC.)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Popularidad
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/Star.svg', // Icono de estrella para mostrar popularidad
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      actor.popularity == 0.0
                          ? 'N/A' // Si la popularidad es 0, muestra 'N/A'
                          : actor.popularity.toString(), // Muestra la popularidad
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFFFF8700), // Color del texto de popularidad
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.home, // Icono para mostrar el lugar de origen
                    color: Colors.white,
                    size: 17),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Container(
                      child: FutureBuilder<DescActor?>( // Llama a la API para obtener detalles del actor
                        future: ApiService.getDetailActor(actor.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator()); // Muestra el loading
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}', // Muestra un mensaje de error
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (snapshot.hasData && snapshot.data != null) {
                            // Muestra el lugar de nacimiento
                            return Text(
                              snapshot.data?.place_of_birth != null && snapshot.data?.place_of_birth != ""
                                ? snapshot.data!.place_of_birth.toString() // Lugar de nacimiento
                                : 'No place of birth aviable', // Si no hay lugar de nacimiento disponible
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'No place of birth aviable (ERROR)', // Error al obtener el lugar de nacimiento
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/calender.svg', // Icono de calendario para la fecha de nacimiento
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Container(
                      child: FutureBuilder<DescActor?>( // Llama a la API para obtener detalles del actor
                        future: ApiService.getDetailActor(actor.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator()); // Muestra el loading
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}', // Muestra un mensaje de error
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (snapshot.hasData && snapshot.data != null) {
                            // Muestra la fecha de nacimiento
                            return Text(
                              snapshot.data?.birthday != null && snapshot.data?.birthday != ""
                                ? snapshot.data!.birthday.toString() // Fecha de nacimiento
                                : 'No birthday aviable', // Si no hay fecha de nacimiento disponible
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'No birthday aviable (ERROR)', // Error al obtener la fecha de nacimiento
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
