import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/drawerAdmin.dart';
import 'package:tienda_god/widgets/listatiendas.dart';
import 'package:tienda_god/widgets/navigatoradmin.dart';
class VentasView extends StatefulWidget {
  const VentasView({super.key});

  @override
  State<VentasView> createState() => _VentasViewState();
}

class _VentasViewState extends State<VentasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text('Tiendas'),),
      drawer: MyDrawerAdmin(),
      body: tiendasLista(),
        bottomNavigationBar: NavA(
        currentPage: 0,
      ),
    );
  }
}