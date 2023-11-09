import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';

class CarritoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<Carrito>(context);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: carrito.productos.isEmpty
          ? Center(
              child: Text(
                'Añada productos al carrito',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cantidad: ${carrito.cantidad}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        'Precio Total: \Bs.${carrito.precio.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: carrito.productos.length,
                    itemBuilder: (context, index) {
                      final producto = carrito.productos[index];
                      return Card(
                        elevation: 3, // Elevación para dar profundidad
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            producto.nombreProducto,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Precio: \Bs.${producto.precio.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          '¿Quiere Eliminar el Producto del Carrito?'),
                                        content: Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancelar'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                carrito.eliminarProducto(
                                                    producto.idProducto);
                                              },
                                              child: Text('Confirmar'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: () {
                                  carrito.aumentarCantidad(producto.idProducto);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () {
                                  carrito.reducirCantidad(producto.idProducto);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          agregarVentaAlServidor(carrito);
        },
        child: Icon(Icons.send),
      ),
      bottomNavigationBar: Nav(
        currentPage: 1,
      ),
    );
  }
}
