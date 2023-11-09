import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/services/producto_service.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';

class ProductoView extends StatefulWidget {
  ProductoView({
    super.key,
  });

  @override
  State<ProductoView> createState() => _ProductoViewState();
}

class _ProductoViewState extends State<ProductoView> {
  bool enCarrito = false;
                           
  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<Carrito>(context);
    late Future<Map<String, dynamic>> _productoFuture;
    final idProducto = ModalRoute.of(context)?.settings.arguments;

    _productoFuture = recuperarProductoPorID('$idProducto');
    return WillPopScope(
      onWillPop: () async {
        // Define la lógica de navegación al presionar el botón de "volver" aquí
        // Por ejemplo, puedes navegar a otra ruta o realizar otras acciones
        Navigator.popAndPushNamed(
          context,
          '/',
        );
        return false; // Devuelve true si deseas permitir que la acción de retroceso continúe, o false para detenerla
      },
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Detalles del Producto'),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _productoFuture,
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
              final producto = snapshot.data ?? {};

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      imagenes + producto['imagen_url'],
                      width: double.infinity,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16.0),
                    dato(
                      texto:
                          'Nombre del Producto:\n- ${producto['nombre_producto']}',
                      icono: Icons.shopping_cart,
                    ),
                    dato(
                      texto: 'Descripción:\n- ${producto['descripcion']}',
                      icono: Icons.list_alt,
                    ),
                    dato(
                      texto: 'Precio:\n- \Bs.${producto['precio']}',
                      icono: Icons.monetization_on,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (enCarrito) {
                          // El producto ya está en el carrito, puedes realizar alguna acción (como eliminarlo)
                          carrito.eliminarProducto(producto['id_producto']);
                        } else if (aux != '') {
                          carrito.agregarProductoSiNoExiste(
                            Productocarrito(
                              idProducto: producto['id_producto'],
                              nombreProducto: producto['nombre_producto'],
                              precio: double.parse(producto['precio']),
                              cantidad: 1,
                              idTienda: int.parse(producto['id_tienda']),
                            ),
                          );

                          const SnackBar(
                              content: Text('Producto Añadido al Carrito'));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text('Error'),
                                content: Text('Inicie Sesión para Continuar'),
                              );
                            },
                          );
                        }
                        setState(() {
                          // Actualiza el estado
                          enCarrito = carrito
                              .productoYaAgregado(producto['id_producto']);
                          print(enCarrito);
                        });
                      },
                      child: Text(enCarrito
                          ? 'Eliminar del Carrito'
                          : 'Agregar al Carrito'),
                    )
                  ],
                ),
              );
            }
          },
        ),
        bottomNavigationBar: Nav(
          currentPage: 0,
        ),
      ),
    );
  }
}

class dato extends StatelessWidget {
  dato({
    super.key,
    required this.texto,
    required this.icono,
  });

  final String texto;
  final icono;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icono,
              size: 36,
              color: Colors.blue,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                texto,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true, // Permite saltos de línea
              ),
            ),
          ],
        ),
      ),
    );
  }
}
