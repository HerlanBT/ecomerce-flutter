import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/compras.dart';
import 'package:tienda_god/widgets/drawerUser.dart';

class ComprasScrean extends StatefulWidget {
  final String idUsuario1;
  const ComprasScrean({
    Key? key, required this.idUsuario1,
  }) : super(key: key);
  @override
  State<ComprasScrean> createState() => _ComprasScreanState();
}class _ComprasScreanState extends State<ComprasScrean> {
  @override
  Widget build(BuildContext context) {
    isLoggedIn=true;
    final idUsuario = widget.idUsuario1;

    return Scaffold(
      drawer: DrawerUser(idUsuario: idUsuario),
      appBar: AppBar(
        title: const Text('Compras Echas'),
        
      ),
      body:Container(
        child: ventasPorUsuarioWidget(idUsuario: idUsuario),
      ),
      bottomNavigationBar: Nav(
        currentPage: 2,
      ),
    );
  }
}

