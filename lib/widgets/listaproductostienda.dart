import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/producto_service.dart';
import 'package:tienda_god/views/model/producto/editarproducto.dart';
import 'package:tienda_god/views/model/producto/producto.dart';

class ProductosLista extends StatelessWidget {
  ProductosLista({super.key, required this.idtienda});
  final String idtienda;
  @override
  Widget build(BuildContext context) {
    final String idTienda=idtienda;
    return FutureBuilder<List<Producto>>(
      future: recuperarProductosPorTienda(idtienda),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos.
        } else if (snapshot.hasError) {
          return Text('No se encontraron productos.');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No se encontraron productos.');
        } else {
          final productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return Dismissible(
                onDismissed: (direction) async {
                  eliminarProducto(producto.idProducto);
                },
                confirmDismiss: (direction) async {
                  bool result = false;
                  result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              '¿Quiere Eliminar el Producto ${producto.nombreProducto}'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  return Navigator.pop(context, false);
                                },
                                child: const Text('Cancelar')),
                            TextButton(
                                onPressed: () {
                                    eliminarProducto(producto.idProducto);
                                  return Navigator.pop(context, true);
                                },
                                child: const Text('Confirmar')),
                          ],
                        );
                      });

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
                key: Key(producto.idProducto),
                child: ListTile(
                    leading: Image.network(imagenes + producto.imagenUrl),
                    title: Text(producto.nombreProducto),
                    subtitle:
                        Text('Precio: \Bs.${producto.precio.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      onPressed: () {
                     Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (BuildContext context) =>
                                       EditarProductoView(idProducto: producto.idProducto, idTienda: idTienda,),
                               ),
                             );
                      },
                      icon: const Icon(Icons.edit),
                      color: Colors.blueGrey,
                    )),
              );
            },
          );
        }
      },
    );
  }
}
