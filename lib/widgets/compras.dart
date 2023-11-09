import 'package:flutter/material.dart';
import 'package:tienda_god/services/carrito.dart';

class ventasPorUsuarioWidget extends StatelessWidget {
  final String idUsuario;

  ventasPorUsuarioWidget({required this.idUsuario});



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ventasPorUsuario(idUsuario),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No se encontraron ventas para este usuario.');
        } else {
      
          final ventas = snapshot.data!;
          return ListView.builder(
  itemCount: ventas.length,
  itemBuilder: (context, index) {
    final venta = ventas[index];
  
    final producto = venta["producto"];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text('Compra'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha de Venta: ${venta["fecha_venta"]}'),
            Text('Precio Total: Bs.${venta["precio_total"]}'),
            Text('Cantidad Total: ${venta["cantidad_total"]}'),
            Text('Producto: ${producto["nombre_producto"]}'),
            Text('Precio del Producto: \Bs.${producto["precio"]}'),
            Text('Cantidad del Producto: ${producto["cantidad"]}'),
          ],
        ),
        // Agrega más información de la venta según tus necesidades...
      ),
    );
  },
);

        }
      },
    );
  }
}
