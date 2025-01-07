import 'package:get/get.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/actor_list_screen.dart';

class BottomNavigatorController extends GetxController {
  // Colección de pantallas que forman parte del navegador inferior
  var screens = [
    HomeScreen(), // Vista de inicio
    const SearchScreen(), // Vista para realizar búsquedas
    const WatchList(), // Vista para la lista de seguimiento
  ];  

  var index = 0.obs; // Variable observable que almacena el índice de la pantalla activa
  
  void setIndex(indx) => index.value = indx; // Método para cambiar la pantalla activa
}
