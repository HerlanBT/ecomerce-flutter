import 'package:flutter/material.dart';
import 'package:tienda_god/services/carrito.dart';

class ventasPorTiendaWidget extends StatelessWidget {
  final String idTienda;

  ventasPorTiendaWidget({required this.idTienda});



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: recuperarVentasTienda(idTienda),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos.
        } else if (snapshot.hasError) {
          return Text('No se encontraron ventas para este usuario.');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No se encontraron ventas para este usuario.');
        } else {
          // Aquí puedes construir la lista o la interfaz gráfica para mostrar las ventas por usuario
          final ventas = snapshot.data!;
          return ListView.builder(
            itemCount: ventas.length,
            itemBuilder: (context, index) {
              final venta = ventas[index];
              // Aquí construyes un widget para mostrar cada venta
              // Puedes acceder a los datos de la venta como venta["id_venta"], venta["precio_total"], etc.
              return ListTile(
                title: Text('Venta ID: ${venta["id_venta"]}'),
                subtitle: Text('Precio Total: \Bs.${venta["precio_total"]}'),
                // Agrega más información de la venta según tus necesidades...
              );
            },
          );
        }
      },
    );
  }
}
