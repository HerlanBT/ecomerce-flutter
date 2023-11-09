import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/drawerAdmin.dart';
import 'package:tienda_god/widgets/listaUsuarios.dart';
import 'package:tienda_god/widgets/navigatoradmin.dart';

class UsuariosView extends StatefulWidget {
  const UsuariosView({super.key});

  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends State<UsuariosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      drawer: MyDrawerAdmin(),
      body: usuariosLista(),
      bottomNavigationBar: NavA(
        currentPage: 0,
      ),
    );
  }
}
