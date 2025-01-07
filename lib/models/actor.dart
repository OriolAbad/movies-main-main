import 'dart:convert';

class Actor {
  // Atributos que representan las propiedades de un actor
  int id; // Identificador único del actor
  String name; // Nombre del actor
  String profilePath; // Ruta de la imagen de perfil del actor
  String originalname; // Nombre original del actor
  String knowdepartment; // Departamento en el que es conocido
  int gender; // Género del actor (1: femenino, 2: masculino, 0: no especificado)
  double popularity; // Nivel de popularidad del actor

  // Constructor que inicializa las propiedades del actor
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.originalname,
    required this.knowdepartment,
    required this.gender,
    required this.popularity,
  });

  // Método que construye un objeto Actor a partir de un mapa (como los datos JSON)
  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int, // Asigna el ID del actor
      name: map['name'] ?? '', // Asigna el nombre o un valor vacío si es nulo
      profilePath: map['profile_path'] ?? '', // Asigna la ruta de perfil o un valor vacío si es nulo
      originalname: map['original_name'] ?? '', // Asigna el nombre original o un valor vacío si es nulo
      knowdepartment: map['known_for_department'] ?? '', // Asigna el departamento o un valor vacío si es nulo
      gender: map['gender'] ?? 0, // Asigna el género o 0 si es nulo
      popularity: map['popularity']?.toDouble() ?? 0.0, // Convierte la popularidad a un valor de tipo double o asigna 0.0 si es nulo
    );
  }

  // Método que construye un objeto Actor a partir de una cadena JSON
  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}
