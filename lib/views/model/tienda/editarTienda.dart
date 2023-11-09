import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/drawerTienda.dart';
import 'package:tienda_god/widgets/editTienda.dart';

import 'package:tienda_god/widgets/widgetsForm.dart';

class EditarTiendaView extends StatefulWidget {
  final String idTienda;

  EditarTiendaView({required this.idTienda});

  @override
  State<EditarTiendaView> createState() => _EditarTiendaViewState();
}

class _EditarTiendaViewState extends State<EditarTiendaView> {
  @override
  Widget build(BuildContext context) {
    final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);

    print(widget.idTienda);

    String idTienda = widget.idTienda;
    return Scaffold(
      drawer: DrawerTienda(idTienda: widget.idTienda),
      appBar: AppBar(
        title: Text('Editar Tienda'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
             iconoproducto(),
            editTienda(
              idTienda: idTienda,
            )
          ],
        ),
      ),
    );
  }
}
