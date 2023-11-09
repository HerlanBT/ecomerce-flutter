import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/crearproducto.dart';
import 'package:tienda_god/widgets/drawerTienda.dart';
import 'package:tienda_god/widgets/widgetsForm.dart';

class CrearProducto extends StatefulWidget {
  const CrearProducto({super.key});

  @override
  State<CrearProducto> createState() => _CrearProductoState();
}

class _CrearProductoState extends State<CrearProducto> {
  @override
  Widget build(BuildContext context) {
    final idTienda = ModalRoute.of(context)?.settings.arguments as String;
        final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);
    return Scaffold(
      drawer: DrawerTienda(idTienda: idTienda,),
      appBar: AppBar(
        title: const Text('Crear  Producto'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
            iconoproducto(),
            createproduct(idusuario:idTienda),
          ],
        ),
      ),
    );
  }
}
