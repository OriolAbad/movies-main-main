import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class SearchController1 extends GetxController {
  // Controlador de texto utilizado para manejar el campo de búsqueda
  TextEditingController searchController = TextEditingController();  
  
  var searchText = ''.obs; // Variable observable que contiene el texto ingresado para buscar
  var foundedActors = <Actor>[].obs; // Lista observable que almacena los actores encontrados
  var isLoading = false.obs; // Indica el estado de carga de la búsqueda
  
  // Actualiza el valor del texto de búsqueda con el texto proporcionado
  void setSearchText(text) => searchText.value = text;  
  
  // Realiza la búsqueda de actores en base al texto proporcionado
  void search(String query) async {
    isLoading.value = true; // Cambia el estado a cargando
    foundedActors.value = (await ApiService.getSearchedActors(query)) ?? []; // Obtiene los resultados y los guarda
    isLoading.value = false; // Finaliza el estado de carga
  }
}
