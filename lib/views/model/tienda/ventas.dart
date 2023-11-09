import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawerTienda.dart';


import 'package:tienda_god/widgets/ventas.dart';

class VentasScrean extends StatefulWidget {
  final String idTienda1;
  const VentasScrean({
    Key? key,
    required this.idTienda1,
  }) : super(key: key);
  @override
  State<VentasScrean> createState() => _VentasScreanState();
}

class _VentasScreanState extends State<VentasScrean> {
  @override
  Widget build(BuildContext context) {
    isLoggedIn = true;
    final idTienda = widget.idTienda1;

    return Scaffold(
drawer: DrawerTienda(idTienda: idTienda,),
      appBar: AppBar(
        title: const Text('Ventas Echas'),
      ),
      body: Container(
        child: ventasPorTiendaWidget(idTienda: idTienda),
      ),
      bottomNavigationBar: Nav(
        currentPage: 2,
      ),
    );
  }
}
