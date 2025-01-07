// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:get/get.dart'; 
import 'package:movies/screens/main.dart';

void main() {
  runApp(const MyApp()); // Inicia la aplicación Flutter llamando a la función principal.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de la clase MyApp, que no tiene estado mutable.

  @override
  Widget build(BuildContext context) {
    // Configura el color de la barra de estado en el sistema.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF242A32), // Color de la barra de estado.
      ),
    );
    
    return GetMaterialApp(  // Usamos GetMaterialApp para habilitar el uso de GetX en la app.
      debugShowCheckedModeBanner: false,  // Desactiva el banner de modo debug en la esquina superior derecha.
      theme: ThemeData( // Define el tema global de la aplicación.
        scaffoldBackgroundColor: const Color(0xFF242A32), // Color de fondo del scaffold de la aplicación.
        textTheme: const TextTheme( // Especifica el estilo global del texto en la app.
          bodyLarge: TextStyle(
            color: Colors.white, // Color del texto en blanco para las secciones principales.
            fontFamily: 'Poppins', // Fuente usada en el texto de la aplicación.
          ),
          bodyMedium: TextStyle(
            color: Colors.white, // Estilo para el texto de tamaño medio.
            fontFamily: 'Poppins', // Fuente 'Poppins' también para este texto.
          ),
        ),
      ),
      home: Main(), // Define la pantalla principal de la aplicación como la pantalla inicial.
    );
  }
}
