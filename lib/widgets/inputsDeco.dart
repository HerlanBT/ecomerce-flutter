import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputDecoration({
    required String hintText,
    required String labelText,
    required Icon icono,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple, width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      prefixIcon: icono,
    );
  }

  static InputDecoration inputDecoration4({
    required String hintText,
    required String labelText,
    required Icon icono,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple, width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      prefixIcon: icono,
      prefixText: '+591 ',
      prefixStyle: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  static InputDecoration inputDecoration2({
    required String hintText,
    required String labelText,
    required Icon icono,
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255), width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
          color: Colors
              .white), // Configura el color del texto de la etiqueta como blanco
      hintStyle: TextStyle(color: Colors.white),
      prefixIcon: icono,
      alignLabelWithHint: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 32.0),
      // Configura el estilo del texto escrito en el campo de texto
    );
  }

  static InputDecoration inputDecoration3({
    required String hintText,
    required String labelText,
    required Icon icono,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 241, 239, 245), width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      prefixIcon: icono,
      labelStyle: TextStyle(
          color: Colors
              .white), // Configura el color del texto de la etiqueta como blanco
      hintStyle: TextStyle(
          color: Colors
              .white), // Configura el color del texto de la pista como blanco
      fillColor: const Color.fromARGB(0, 255, 255,
          255), // Configura el color de fondo del campo de texto como blanco
      filled: true,
    );
  }
    static InputDecoration inputDecoration5({
    required String hintText,
    required String labelText,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 241, 239, 245), width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
          color: Colors
              .white), // Configura el color del texto de la etiqueta como blanco
      hintStyle: TextStyle(
          color: Colors
              .white), // Configura el color del texto de la pista como blanco
      fillColor: const Color.fromARGB(0, 255, 255,
          255), // Configura el color de fondo del campo de texto como blanco
      filled: true,
    );
  }
}

