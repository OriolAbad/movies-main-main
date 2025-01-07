import 'dart:convert';

class Movie {
  // Propiedades que contienen la información básica de la película
  int id; // ID único de la película
  String title; // Título de la película
  String posterPath; // Ruta de la imagen del cartel (poster) de la película
  String backdropPath; // Ruta de la imagen de fondo de la película
  String overview; // Descripción general de la película
  String releaseDate; // Fecha de lanzamiento de la película
  double voteAverage; // Promedio de votos (calificación) de la película
  List<int> genreIds; // Lista de IDs de géneros asociados a la película

  // Constructor para inicializar los datos de la película
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  // Método para crear un objeto Movie a partir de un mapa (por ejemplo, un objeto JSON)
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int, // ID de la película
      title: map['title'] ?? '', // Título de la película, valor por defecto: cadena vacía
      posterPath: map['poster_path'] ?? '', // Ruta del cartel (poster), valor por defecto: cadena vacía
      backdropPath: map['backdrop_path'] ?? '', // Ruta de la imagen de fondo, valor por defecto: cadena vacía
      overview: map['overview'] ?? '', // Descripción general, valor por defecto: cadena vacía
      releaseDate: map['release_date'] ?? '', // Fecha de lanzamiento, valor por defecto: cadena vacía
      voteAverage: map['vote_average']?.toDouble() ?? 0.0, // Promedio de votos, valor por defecto: 0.0
      genreIds: List<int>.from(map['genre_ids']), // Lista de géneros asociados a la película
    );
  }

  // Método para crear un objeto Movie a partir de una cadena JSON
  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
