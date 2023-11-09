// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/producto_service.dart';
import 'package:tienda_god/widgets/MenuIconos.dart';
import 'package:tienda_god/widgets/ListHome.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();

    obtenerProductosDiferentes();
  }

  @override
  Widget build(BuildContext context) {
    print("este es el id=>$aux");
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: const Text('Inicio')),
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
                    child: const Text('Aplicacion De Ventas \nEcha por Illimani Code  😎👌 Ahre '),
                  ),
                ],
              ),
            ),
            // Contenedor con botón
            MenuIconos(),

            // Contenedor de la lista
            Column(children: [
              Container(
                color: Colors.purple,
                height: 50, // Establece la altura deseada
                child: const Center(
                  child: Text(
                    'Productos',
                    style: TextStyle(
                      color: Colors.white, // Cambia el color del texto a blanco
                      fontSize: 25, // Cambia el tamaño de la fuente
                    ),
                  ),
                ),
              ),
              ListHome()
            ]),
          ],
        ),
      ),
      bottomNavigationBar: Nav(
        currentPage: 0,
      ),
    );
  }
}
