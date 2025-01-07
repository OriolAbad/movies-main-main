import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/models/descactor.dart';
import 'package:movies/models/actor.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';

class ApiService {

  // Recupera una lista de actores mejor valorados de la semana
  static Future<List<Actor>?> getTopRatedActors() async {
    List<Actor> actors = [];
    try {      
      http.Response response = await http.get(Uri.parse( // Envía la solicitud HTTP
          '${Api.baseUrl}trending/person/week?language=en-US&api_key=${Api.apiKey}'));
      var res = jsonDecode(response.body);
      // Selecciona un rango de resultados: omite los primeros 6 y toma los 5 siguientes
      res['results'].skip(6).take(5).forEach(
            (m) => actors.add(
              Actor.fromMap(m),
            ),
          );
      return actors;
    } catch (e) {
      return null; 
    }
  }

  // Recupera información detallada de un actor según su ID
  static Future<DescActor?> getDetailActor(String idactor) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Api.baseUrl}person/$idactor?api_key=${Api.apiKey}&language=en-US'),
      );
      var res = jsonDecode(response.body); // Convierte la respuesta en un objeto
      return DescActor.fromMap(res); // Transforma el objeto en un modelo DescActor
    } catch (e) {
      return null;
    }
  }

  // Obtiene una lista de actores a partir de una URL personalizada
  static Future<List<Actor>?> getCustomActors(String url) async {
    List<Actor> actors = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}person/popular?language=en-US&api_key=${Api.apiKey}${url}'));
      var res = jsonDecode(response.body);
      // Procesa los primeros 6 resultados de la respuesta
      res['results'].take(6).forEach(
            (m) => actors.add(
              Actor.fromMap(m),
            ),
          );
      return actors;
    } catch (e) {
      return null;
    }
  }

  // Busca actores basándose en una consulta proporcionada
  static Future<List<Actor>?> getSearchedActors(String query) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/person?language=en-US&api_key=${Api.apiKey}&include_adult=false&query=$query'));
      var res = jsonDecode(response.body);      
      res['results'].forEach( // Añade cada actor encontrado a la lista
        (m) => actors.add(
          Actor.fromMap(m),
        ),
      );
      return actors;
    } catch (e) {
      return null;
    }
  }

  // Recupera las reseñas de una película específica mediante su ID
  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);      
      res['results'].forEach( // Añade cada reseña a la lista
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }
}
