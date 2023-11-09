import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/tienda_service.dart';




class tiendasLista extends StatelessWidget {
  tiendasLista({super.key, });
  
  @override
  Widget build(BuildContext context) {
    

    return FutureBuilder<List<dynamic>>(
      future: obtenerTodasLasTiendas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos.
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text('No se encontraron productos.');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No se encontraron productos.');
        } else {
          
          final tiendas = snapshot.data!;
          print(tiendas);
          return ListView.builder(
            itemCount: tiendas.length,
            itemBuilder: (context, index) {
              final tienda = tiendas[index];
              return Dismissible(
                confirmDismiss: (direction) async {
        
                    bool result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              '¿Quiere Eliminar a ${tienda['nombre_tienda']} de la Base de Datos?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                               
                              },
                              child: const Text('Confirmar'),
                            ),
                          ],
                        );
                      },
                    );
                    return result; 
                  
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                direction: DismissDirection.endToStart,
                key: Key(tienda['id_tienda']),
                child: ListTile(
                  leading: Image.network(imagenes + tienda['logo_url']),
                  title: Text('Nombre Tienda: ${tienda['nombre_tienda']}'),
                  subtitle:Text('Telefono: ${tienda['telefono']}\nid_tienda: ${tienda['id_tienda']}\nFecha Registro: ${tienda['fecha_tienda']}'),
                ),
              );
            },
          );
        }
      },
    );
  }
}
