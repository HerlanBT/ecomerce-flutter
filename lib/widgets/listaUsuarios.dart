import 'package:flutter/material.dart';

import 'package:tienda_god/services/usuario_service.dart';




class usuariosLista extends StatelessWidget {
  usuariosLista({super.key, });
  
  @override
  Widget build(BuildContext context) {
    

    return FutureBuilder<List<dynamic>>(
      future: obtenerUsuarios(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos.
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text('No se encontraron productos.');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No se encontraron productos.');
        } else {
          
          final usuarios = snapshot.data!;
          print(usuarios);
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return Dismissible(
                confirmDismiss: (direction) async {
        
                    bool result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              '¿Quiere Eliminar a ${usuario['id_usuario']} de la Base de Datos?'),
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
                key: Key(usuario['id_usuario']),
                child: ListTile(
                  leading: const Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 30.0,
                      ),
                  
                  title: Text('Nombre Completo: ${usuario['nombre']} ${usuario['apellido']}'),
                  subtitle:Text('Correo: ${usuario['correo_electronico']}\nTelefono: ${usuario['telefono']}\nid_usuario: ${usuario['id_usuario']}'),
                ),
              );
            },
          );
        }
      },
    );
  }
}
