class Review {
  // Propiedades que contienen la información de la reseña
  String author; // Nombre del autor de la reseña
  String comment; // Contenido de la reseña
  double rating; // Calificación de la reseña (valor numérico)

  // Constructor para inicializar los datos de la reseña
  Review({
    required this.author,
    required this.comment,
    required this.rating,
  });

  // Método para crear un objeto Review desde un mapa (por ejemplo, un objeto JSON)
  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      author: map['author'] ?? '', // Nombre del autor, valor por defecto: cadena vacía
      comment: map['content'] ?? '', // Contenido de la reseña, valor por defecto: cadena vacía
      rating: map['rating']?.toDouble() ?? 0.0, // Calificación de la reseña, valor por defecto: 0.0
    );
  }
}
