import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/views/model/producto/producto.dart';
import 'package:tienda_god/services/producto_service.dart';

class ListHome extends StatefulWidget {
  const ListHome({
    Key? key,
  }) : super(key: key);

  @override
  State<ListHome> createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  late Future<List<Producto>> productosFuture;

  @override
  void initState() {
    super.initState();
    productosFuture = obtenerProductosDiferentes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Producto>>(
      future: productosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los productos.
        } else if (snapshot.hasError) {
          return Text('No se encontraron productos.');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No se encontraron productos');
        } else {
          final productos = snapshot.data!;

          return SingleChildScrollView(
            scrollDirection: Axis
                .horizontal, // Establece la dirección de desplazamiento horizontal
            child: Row(
              children: productos.map((producto) {
                return InkWell(
                  onTap: () {
                    print(producto.idProducto);
                    Navigator.pushReplacementNamed(context, '/producto',
                        arguments: producto.idProducto);
                  },
                  child: Card(
                    elevation: 9,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          '$imagenes${producto.imagenUrl}',
                          width: 150, // Ancho de la imagen
                          height: 150, // Alto de la imagen
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error al cargar la imagen: $error');
                            return const Icon(Icons.error);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            producto.nombreProducto,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text('\Bs.${producto.precio.toStringAsFixed(1)}'),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
