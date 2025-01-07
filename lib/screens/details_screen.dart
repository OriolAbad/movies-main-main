import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/descactor.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.actor, // Se recibe el actor a mostrar
  });
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Cabecera con el botón de retroceso, el título y el botón para guardar al actor
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Botón para volver a la pantalla anterior
                    IconButton(
                      tooltip: 'Back to home', 
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios, // Icono de flecha hacia atrás
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Detail', // Título de la pantalla
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    // Botón para agregar el actor a la lista de seguimiento
                    Tooltip(
                      message: 'Save this actor to your watch list', // Tooltip al presionar el icono
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<ActorsController>().addToActorsList(actor); // Agregar actor a la lista
                        },
                        icon: Obx(
                          () =>
                            Get.find<ActorsController>().isInActorsList(actor)
                              ? const Icon(
                                  Icons.bookmark, // Icono de marcador si está en la lista
                                  color: Colors.white,
                                  size: 33,
                                )
                              : const Icon(
                                  Icons.bookmark_outline, // Icono de marcador vacío
                                  color: Colors.white,
                                  size: 33,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // Sección para mostrar la imagen del actor
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    // Fondo con la imagen del actor
                    Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16), 
                          bottomRight: Radius.circular(16),
                        ),
                        child: SizedBox.expand( // Expande el área de la imagen
                          child: FittedBox(
                            fit: BoxFit.cover, // Asegura que la imagen cubra todo el espacio
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${actor.profilePath}', // URL de la imagen del actor
                              loadingBuilder: (_, __, ___) {
                                // Si la imagen está cargando
                                if (___ == null) return __; 
                                return FadeShimmer(
                                  width: Get.width,
                                  height: 250,
                                  highlightColor: const Color(0xff22272f),
                                  baseColor: const Color(0xff20252d),
                                );
                              },
                              errorBuilder: (_, __, ___) => const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.broken_image, // Icono si la imagen no se carga
                                  size: 250,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Imagen pequeña del actor en la esquina inferior izquierda
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${actor.profilePath}', // Imagen del actor
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover, // Asegura que la imagen se ajuste correctamente
                            loadingBuilder: (_, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Imagen cargada
                              } else {
                                return const FadeShimmer(
                                  width: 110,
                                  height: 140,
                                  highlightColor: Color(0xff22272f),
                                  baseColor: Color(0xff20252d),
                                ); // Imagen aún cargando
                              }
                            },
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person_off, // Icono de error si la imagen no se carga
                              size: 120,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Nombre del actor sobre la imagen de fondo
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Container(
                          color: Colors.white, // Fondo blanco para el nombre
                          child: Text(
                            actor.name, // Nombre del actor
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Información de popularidad sobre la imagen
                    Positioned(
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/Star.svg'), // Icono de estrella
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              actor.popularity == 0.0
                                ? 'No data available' // Si no hay datos de popularidad
                                : actor.popularity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // Información adicional como fecha de nacimiento y lugar de nacimiento
              Opacity(
                opacity: .6,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth * 0.9, // Ajustar el ancho
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/calender.svg'), // Icono de calendario
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: FutureBuilder<DescActor?>( // Obtener detalles del actor
                                  future: ApiService.getDetailActor(actor.id.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          'Error: ${snapshot.error}', // Mostrar error si ocurre
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                      );
                                    } else if (snapshot.hasData && snapshot.data != null) {
                                      return Text(
                                        snapshot.data?.birthday != null && snapshot.data?.birthday != "" 
                                          ? snapshot.data!.birthday.toString()
                                          : 'No birthday available', // Mostrar cumpleaños
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                          'No birthday available (ERROR)', // Si no hay cumpleaños disponible
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Text('|'),
                          Row(
                            children: [
                              Icon(Icons.home, color: Colors.white, size: 17), // Icono de lugar de nacimiento
                              const SizedBox(width: 5),
                              FutureBuilder<DescActor?>( // Obtener lugar de nacimiento
                                future: ApiService.getDetailActor(actor.id.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'Error: ${snapshot.error}', // Mostrar error si ocurre
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                    );
                                  } else if (snapshot.hasData && snapshot.data != null) {
                                    return Text(
                                      snapshot.data?.place_of_birth != null && snapshot.data?.place_of_birth != ""
                                        ? snapshot.data!.place_of_birth.toString()
                                        : 'No place of birth available', // Mostrar lugar de nacimiento
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text(
                                        'No place of birth available (ERROR)', // Si no hay lugar de nacimiento disponible
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Sección para mostrar las pestañas de información adicional
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Pestañas de información sobre el actor y sus películas
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'About Actors'), // Pestaña sobre el actor
                            Tab(text: 'Movies'), // Pestaña de películas
                          ]),
                      // Contenido de las pestañas
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder<DescActor?>( // Obtener biografía del actor
                              future: ApiService.getDetailActor(actor.id.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      'Error: ${snapshot.error}', // Mostrar error si ocurre
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  );
                                } else if (snapshot.hasData && snapshot.data != null) {
                                  return SingleChildScrollView(
                                    child: Text(
                                    snapshot.data?.biography != null && snapshot.data?.biography != ""
                                        ? snapshot.data!.biography.toString() 
                                        : 'No biography available', // Mostrar biografía
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                    ),
                                  );
                                } else {
                                  return const Center(child: Text('No biography available (ERROR)'));
                                }
                              },
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
