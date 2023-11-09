import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/tienda_service.dart';

class TiendaWidget extends StatelessWidget {
  const TiendaWidget({
    Key? key,
    required this.idTienda,
  }) : super(key: key);

  final String idTienda;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: recuperarTiendaId(idTienda),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final tienda = snapshot.data ?? {};

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9, // Puedes ajustar la relación de aspecto según tus necesidades
                child: Image.network(imagenes + tienda["logo_url"]),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${tienda["nombre_tienda"] ?? "No disponible"}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('ID: ${tienda["id"] ?? "No disponible"}'),
                    Text('Telefono: ${tienda["telefono"] ?? "No disponible"}'),
                    Text('Fecha de Registro: ${tienda["fecha_tienda"] ?? "No disponible"}'),
                    Text('ID de tienda: ${tienda["id_tienda"] ?? "No disponible"}'),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
