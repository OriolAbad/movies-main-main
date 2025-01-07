import 'package:fade_shimmer/fade_shimmer.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/widgets/infos.dart';
import 'package:movies/widgets/search_box.dart';

// Pantalla de búsqueda de actores.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Permite el desplazamiento de la pantalla
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
        child: Column(
          children: [            
            Row( // Encabezado con opciones de navegación y título.
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                
                IconButton( // Botón para volver al inicio.
                  tooltip: 'Back to home',
                  onPressed: () =>
                      Get.find<BottomNavigatorController>().setIndex(0),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),                
                const Text( // Título de la pantalla.
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),                
                const Tooltip( // Tooltip de información con un ícono.
                  message: 'Search your wanted actor here !',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),            
            SearchBox( // Caja de búsqueda personalizada que permite ingresar el nombre del actor.
              onSumbit: () { // Acción cuando se envía la búsqueda.
                String search =
                    Get.find<SearchController1>().searchController.text;
                Get.find<SearchController1>().searchController.text = '';
                Get.find<SearchController1>().search(search); // Llama al método de búsqueda.
                FocusManager.instance.primaryFocus?.unfocus(); // Quita el foco del TextField.
              },
            ),
            const SizedBox(
              height: 34,
            ),            
            Obx( // Observador reactivo que escucha cambios en el estado y actualiza la UI.
              (() => Get.find<SearchController1>().isLoading.value
                  ? const CircularProgressIndicator() // Muestra un indicador de carga mientras busca.
                  : Get.find<SearchController1>().foundedActors.isEmpty
                      ? SizedBox( // Mensaje si no se encuentra ningún actor.
                          width: Get.width / 1.5,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 120,
                              ),
                              SvgPicture.asset(
                                'assets/no.svg',
                                height: 120,
                                width: 120,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'We Are Sorry, We Can Not Find The Actor :(',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  wordSpacing: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Opacity(
                                opacity: .8,
                                child: Text(
                                  'Find your Actor by name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated( // Lista de actores encontrados.
                          itemCount:
                              Get.find<SearchController1>().foundedActors.length,
                          shrinkWrap: true, // Evita que la lista se expanda más allá de la pantalla.
                          physics: const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento de la lista.
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 24), // Separadores entre los elementos.
                          itemBuilder: (_, index) { // Construye cada item de la lista.
                            Actor actor = Get.find<SearchController1>() // Obtiene el actor desde el controlador.
                                .foundedActors[index];
                            return GestureDetector(
                              onTap: () => Get.to(DetailsScreen(actor: actor)), // Navega a la pantalla de detalles del actor.
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [                                  
                                  ClipRRect( // Imagen del actor con placeholder en caso de error o carga.
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      Api.imageBaseUrl + actor.profilePath, // Ruta a la imagen del actor.
                                      height: 180,
                                      width: 120,
                                      fit: BoxFit.cover, // Ajuste de la imagen dentro del contenedor.
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.person_off,
                                        size: 120, // Ícono que se muestra si hay un error en la carga de la imagen.
                                      ),
                                      loadingBuilder: (_, __, ___) {
                                        if (___ == null) return __;
                                        return const FadeShimmer(
                                          width: 120,
                                          height: 180,
                                          highlightColor: Color(0xff22272f),
                                          baseColor: Color(0xff20252d),
                                        ); // Efecto de carga mientras se obtiene la imagen.
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),                                  
                                  Expanded( // Información adicional del actor (como nombre y detalles).
                                    child: Infos(actor: actor),
                                  ),
                                ],
                              ),
                            );
                          })), // Fin de la construcción de la lista.
            ),
          ],
        ),
      ),
    );
  }
}
