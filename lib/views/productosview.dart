import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';
import 'package:tienda_god/widgets/listaproductostipos.dart';
import 'package:tienda_god/widgets/listarowprdtipo.dart';

class ProductosVenta extends StatefulWidget {
  const ProductosVenta({super.key});

  @override
  State<ProductosVenta> createState() => _ProductosVentaState();
}

class _ProductosVentaState extends State<ProductosVenta> {
  @override
  Widget build(BuildContext context) {
    final tipoproducto = ModalRoute.of(context)?.settings.arguments as String;
    return WillPopScope(
        onWillPop: () async {
              Navigator.popAndPushNamed(context, '/');
        return false; 
      },
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(tipoproducto),
        ),
        body: Column(
          children: [
            listaTipoPrd(),
            Expanded(
              child: productosListaTipo(
                tipoproducto: tipoproducto,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Nav(
          currentPage: 0,
        ),
      ),
    );
  }
}
