// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/producto_service.dart';
import 'package:tienda_god/widgets/MenuIconos.dart';
import 'package:tienda_god/widgets/ListHome.dart';
import 'package:tienda_god/widgets/botonesaccion.dart';
import 'package:tienda_god/widgets/drawerAdmin.dart';
import 'package:tienda_god/widgets/navigatoradmin.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  void initState() {
    super.initState();

    obtenerProductosDiferentes();
  }

  @override
  Widget build(BuildContext context) {
    print("este es el id=>$aux");
    return Scaffold(
      drawer: MyDrawerAdmin(),
      appBar: AppBar(title: const Text('Este es el admin')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Row(
                children: <Widget>[
                  // Contenedor de la imagen
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/Logo.jpg'),
                  ),
                  // Contenedor del título
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: const Text('MODO ADMINISTRADOR PAPU  '),
                  ),
                ],
              ),
            ),
            // Contenedor con botón
            MenuIconos(),
            Column(
              children: [
                Container(
                  color: Colors.purple,
                  height: 50, // Establece la altura deseada
                  child: const Center(
                    child: Text(
                      'Acciones',
                      style: TextStyle(
                        color:
                            Colors.white, // Cambia el color del texto a blanco
                        fontSize: 25, // Cambia el tamaño de la fuente
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonacciones(texto: 'Tiendas', icono: Icons.store),
                      buttonacciones(
                        texto: 'Ventas',
                        icono: Icons.shopping_cart,
                      ),
                      buttonacciones(
                        texto: 'Usuarios',
                        icono: Icons.person,
                      ),
                    ],
                  ),
                )
              ],
            ),

            Column(
              children: [
                Container(
                  color: Colors.purple,
                  height: 50, // Establece la altura deseada
                  child: const Center(
                    child: Text(
                      'Productos',
                      style: TextStyle(
                        color:
                            Colors.white, // Cambia el color del texto a blanco
                        fontSize: 25, // Cambia el tamaño de la fuente
                      ),
                    ),
                  ),
                ),
                ListHome()
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavA(
        currentPage: 0,
      ),
    );
  }
}
