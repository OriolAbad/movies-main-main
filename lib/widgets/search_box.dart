import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/search_controller.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    required this.onSumbit, // Recibe un callback cuando se realiza la búsqueda
    super.key,
  });
  final VoidCallback onSumbit; // Callback para ejecutar al enviar la búsqueda

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Get.find<SearchController1>().searchController, // Usa el controlador de búsqueda de GetX
      style: const TextStyle(color: Colors.white), // Define el color del texto dentro del campo de texto
      decoration: InputDecoration(
        suffixIcon: IconButton( // Icono para ejecutar la búsqueda
          icon: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14),
            child: SvgPicture.asset(
              'assets/Search.svg', // Carga el icono SVG de búsqueda
              width: 22,
              height: 22,
            ),
          ),
          onPressed: () => onSumbit(), // Ejecuta la función proporcionada cuando se presiona el botón
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none, // Elimina el borde por defecto
        ),
        hintStyle: const TextStyle(
          color: Color(
            0xFF67686D,
          ),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.only(
          left: 16, // Relleno del lado izquierdo
          right: 0,
          top: 0,
          bottom: 0,
        ),
        filled: true, // Define que el fondo del campo de texto esté relleno
        fillColor: const Color(0xFF3A3F47), // Color de fondo del campo de texto
        hintText: 'Search',
      ),
      onSubmitted: (a) => onSumbit(), // Ejecuta el callback cuando el usuario presiona 'Enter'
    );
  }
}
