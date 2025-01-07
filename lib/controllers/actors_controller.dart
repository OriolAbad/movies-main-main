import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class ActorsController extends GetxController {
  var isLoading = false.obs; // Variable observable que indica si se está realizando una carga
  var mainTopRatedActors = <Actor>[].obs; // Lista observable que almacena los actores más destacados
  var watchListActors = <Actor>[].obs; // Lista observable para los actores en la lista de seguimiento

  @override
  void onInit() async {
    // Se ejecuta cuando se inicializa el controlador para cargar los actores principales
    isLoading.value = true; // Cambia el estado de carga a activo
    mainTopRatedActors.value = (await ApiService.getTopRatedActors())!; // Recupera los actores más destacados
    isLoading.value = false; // Cambia el estado de carga a inactivo
    super.onInit(); // Llama al método inicializador del padre
  }
  
  bool isInActorsList(Actor actor) {
    // Comprueba si un actor específico ya está presente en la lista de seguimiento
    return watchListActors.any((m) => m.id == actor.id); // Compara los identificadores de los actores
  }

  void addToActorsList(Actor actor) {
    // Añade un actor a la lista de seguimiento o lo elimina si ya está presente
    if (watchListActors.any((m) => m.id == actor.id)) {
      // Si el actor ya está en la lista, lo elimina
      watchListActors.remove(actor);
      Get.snackbar(
        'Success', 
        'Actor removed from the watch list', // Notifica la eliminación del actor
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 1),
      );
    } else {
      // Si el actor no está en la lista, lo agrega
      watchListActors.add(actor);
      Get.snackbar(
        'Success', 
        'Actor added to the watch list', // Notifica la adición del actor
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 1),
      );
    }
  }
}
