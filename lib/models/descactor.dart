import 'dart:convert';

class DescActor {
  // Propiedades que representan la información detallada del actor
  int id; // Identificador único del actor
  String name; // Nombre completo del actor
  String profilePath; // Ruta de la imagen de perfil del actor
  String birthday; // Fecha de nacimiento del actor
  String knowdepartment; // Departamento en el que destaca (ej. actuación, dirección)
  String place_of_birth; // Lugar de nacimiento del actor
  double popularity; // Nivel de popularidad del actor
  String biography; // Biografía completa del actor

  // Constructor que inicializa las propiedades de DescActor
  DescActor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.birthday,
    required this.knowdepartment,
    required this.place_of_birth,
    required this.popularity,
    required this.biography,
  });

  // Método que crea una instancia de DescActor a partir de un mapa (como un objeto JSON)
  factory DescActor.fromMap(Map<String, dynamic> map) {
    return DescActor(
      id: map['id'] as int, // ID único
      name: map['name'] ?? '', // Nombre del actor, valor por defecto: cadena vacía
      profilePath: map['profile_path'] ?? '', // Ruta de la imagen de perfil, valor por defecto: cadena vacía
      birthday: map['birthday'] ?? '', // Fecha de nacimiento, valor por defecto: cadena vacía
      knowdepartment: map['known_for_department'] ?? '', // Departamento destacado, valor por defecto: cadena vacía
      place_of_birth: map['place_of_birth'] ?? '', // Lugar de nacimiento, valor por defecto: cadena vacía
      popularity: map['popularity']?.toDouble() ?? 0.0, // Popularidad convertida a double, valor por defecto: 0.0
      biography: map['biography'] ?? '', // Biografía, valor por defecto: cadena vacía
    );
  }

  // Método que crea una instancia de DescActor a partir de una cadena JSON
  factory DescActor.fromJson(String source) => DescActor.fromMap(json.decode(source));
}
