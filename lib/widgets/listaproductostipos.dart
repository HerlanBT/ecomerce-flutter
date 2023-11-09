import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/services/producto_service.dart';
import 'package:tienda_god/views/model/producto/producto.dart';

class productosListaTipo extends StatelessWidget {
  productosListaTipo({super.key, required this.tipoproducto});
  final String tipoproducto;
  @override
  Widget build(BuildContext context) {
    print(aux);
    final carrito = Provider.of<Carrito>(context);
    return FutureBuilder<List<Producto>>(
      future: obtenerProductosPorTipo(tipoproducto),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos.
        } else if (snapshot.hasError) {
          print(snapshot.error);
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
                confirmDismiss: (direction) async {
                  if (aux == '') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text('Error'),
                          content: Text('Inicie Sesión para Continuar'),
                        );
                      },
                    );
                    return false; // Impedir el despido si no ha iniciado sesión
                  } else {
                    bool result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              '¿Quiere Agregar el Producto ${producto.nombreProducto} Al Carrito?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                carrito.agregarProductoSiNoExiste(
                                  Productocarrito(
                                    idProducto: producto.idProducto,
                                    nombreProducto: producto.nombreProducto,
                                    precio: producto.precio,
                                    cantidad: 1,
                                    idTienda: producto.idTienda,
                                  ),
                                );
                                print(producto.nombreProducto);
                                print(producto.precio);
                                print(producto.idTienda);
                                print(carrito.idUsuario);

                                for (final producto in carrito.productos) {
                                  print('ID: ${producto.idProducto}');
                                  print('Nombre: ${producto.nombreProducto}');
                                  print(
                                      'Precio: ${producto.precio.toStringAsFixed(2)}');
                                  print('Cantidad: ${producto.cantidad}');
                                  print('ID de Tienda: ${producto.idTienda}');
                                  print('---'); // Separador entre productos
                                }
                                Navigator.pop(context, true);
                              },
                              child: const Text('Confirmar'),
                            ),
                          ],
                        );
                      },
                    );
                    return result; // Devuelve la decisión del usuario
                  }
                },
                background: Container(
                  color: Colors.blue,
                  child: const Icon(
                    Icons.add_shopping_cart_sharp,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                direction: DismissDirection.endToStart,
                key: Key(producto.idProducto),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/producto',
                        arguments: producto.idProducto);
                  },
                  child: ListTile(
                    leading: Image.network(imagenes + producto.imagenUrl),
                    title: Text(producto.nombreProducto),
                    subtitle: Text(
                        'Precio: \Bs.${producto.precio.toStringAsFixed(2)}'),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
