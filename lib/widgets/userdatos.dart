import 'package:flutter/material.dart';
import 'package:tienda_god/services/usuario_service.dart';

FutureBuilder<Map<String, dynamic>> usuario(String? idUsuario) {
    return FutureBuilder<Map<String, dynamic>>(
      future: obtenerUsuario(idUsuario),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final usuario = snapshot.data ?? {};

          return SingleChildScrollView(
            child: Card(
                margin: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        dato('Nombre', usuario["nombre"] ?? "No disponible",
                            Icons.person),
                        dato('Apellido', usuario["apellido"] ?? "No disponible",
                            Icons.person),
                        dato(
                            'Correo Electrónico',
                            usuario["correo_electronico"] ?? "No disponible",
                            Icons.email),
                        dato('Teléfono', usuario["telefono"] ?? "No disponible",
                            Icons.phone),
                        dato('ID de Usuario',
                            usuario["id_usuario"] ?? "No disponible", Icons.key),
                      ],
                    ),
                  ],
                )),
          );
        }
      },
    );
  }


Widget dato(String title, String content, IconData icono) {
  return Row(
    children: [
      Icon(
        icono,
        color: Colors.purple,
        size: 30.0,
      ),
     const  SizedBox(width: 10,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey, // Puedes personalizar el color
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    ],
  );
}
