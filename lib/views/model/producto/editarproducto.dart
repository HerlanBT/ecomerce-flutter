import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/drawerTienda.dart';
import 'package:tienda_god/widgets/editproduc.dart';
import 'package:tienda_god/widgets/widgetsForm.dart';

class EditarProductoView extends StatefulWidget {
  final String idProducto;
  final String idTienda;

  EditarProductoView({required this.idProducto, required this.idTienda});

  @override
  State<EditarProductoView> createState() => _EditarProductoViewState();
}

class _EditarProductoViewState extends State<EditarProductoView> {
  @override
  Widget build(BuildContext context) {
    final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);
    print(widget.idProducto);
    print(widget.idTienda);
    String idProducto = widget.idProducto;
    String idTienda = widget.idTienda;
    return Scaffold(
      drawer: DrawerTienda(idTienda: widget.idTienda),
      appBar: AppBar(
        title: Text('Editar Producto'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
            editproduct(
              idProductos: idProducto,
              idTienda: idTienda,
            )
          ],
        ),
      ),
    );
  }
}
