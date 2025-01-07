import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';

class Main extends StatelessWidget {
  Main({super.key});
  
  // Instancia del controlador para gestionar la barra de navegación
  final BottomNavigatorController controller = Get.put(BottomNavigatorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          // Desenfoca cualquier campo de texto cuando se toca fuera de ellos
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            // Muestra la pantalla actual según el índice del controlador
            child: IndexedStack(
              index: controller.index.value, // Muestra la pantalla correspondiente al índice actual
              children: Get.find<BottomNavigatorController>().screens, // Lista de pantallas gestionadas por el controlador
            ),
          ),
          bottomNavigationBar: Container(
            height: 78, // Establece la altura de la barra de navegación
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0296E5), // Color del borde superior
                  width: 1, // Ancho del borde superior
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.index.value, // Índice del ítem seleccionado en la barra de navegación
              onTap: (index) =>
                  // Cambia el índice del controlador para navegar entre pantallas
                  Get.find<BottomNavigatorController>().setIndex(index),
              backgroundColor: const Color(0xFF242A32), // Color de fondo de la barra de navegación
              selectedItemColor: const Color(0xFF0296E5), // Color del ítem seleccionado
              unselectedItemColor: const Color(0xFF67686D), // Color de los ítems no seleccionados
              selectedFontSize: 12, // Tamaño de fuente de los ítems seleccionados
              unselectedFontSize: 12, // Tamaño de fuente de los ítems no seleccionados
              items: [
                // Primer ítem de la barra (pantalla Home)
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6), // Margen inferior para el ícono
                    child: SvgPicture.asset(
                      'assets/Home.svg', // Ícono SVG para la pantalla Home
                      height: 21,
                      width: 21,
                      color: controller.index.value == 0
                          ? const Color(0xFF0296E5) // Color cuando el ítem está seleccionado
                          : const Color(0xFF67686D), // Color cuando el ítem no está seleccionado
                    ),
                  ),
                  label: 'Home', // Etiqueta para el primer ítem
                ),
                // Segundo ítem de la barra (pantalla Search)
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6), // Margen inferior para el ícono
                    child: SvgPicture.asset(
                      'assets/Search.svg', // Ícono SVG para la pantalla Search
                      height: 21,
                      width: 21,
                      color: controller.index.value == 1
                          ? const Color(0xFF0296E5) // Color cuando el ítem está seleccionado
                          : const Color(0xFF67686D), // Color cuando el ítem no está seleccionado
                    ),
                  ),
                  label: 'Search', // Etiqueta para el segundo ítem
                  tooltip: 'Search Actors', // Tooltip que aparece al pasar el cursor (solo en web)
                ),
                // Tercer ítem de la barra (pantalla Save/Actors list)
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6), // Margen inferior para el ícono
                    child: SvgPicture.asset(
                      'assets/Save.svg', // Ícono SVG para la pantalla Save/Actors list
                      height: 21,
                      width: 21,
                      color: controller.index.value == 2
                          ? const Color(0xFF0296E5) // Color cuando el ítem está seleccionado
                          : const Color(0xFF67686D), // Color cuando el ítem no está seleccionado
                    ),
                  ),
                  label: 'Actors list', // Etiqueta para el tercer ítem
                  tooltip: 'Your ActorsList', // Tooltip para este ítem
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
