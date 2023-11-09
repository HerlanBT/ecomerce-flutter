import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/services/tienda_service.dart';
import 'package:tienda_god/services/usuario_service.dart';

class MyDrawerAdmin extends StatefulWidget {
  // Variable para controlar el estado de inicio de sesión

  const MyDrawerAdmin({Key? key}) : super(key: key);

  @override
  State<MyDrawerAdmin> createState() => _MyDrawerAdminState();
}

class _MyDrawerAdminState extends State<MyDrawerAdmin> {
   
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
       const   DrawerHeader(
            child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bienvenido, Admin'),
                      SizedBox(height: 10),
                    ],
                  )
               
          ),
     
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Lista de Tiendas'),
                  onTap: () {
                    obtenerTodasLasTiendas();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('Listas de Compras'),
                  onTap: () {
                    recuperarVentas();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Lista de Usuarios'),
                  onTap: () {
             obtenerUsuarios();
                  },
                ),
                     ElevatedButton(
            onPressed: () async{
              
          if (await cerrarSesion()) {
                Navigator.of(context).pushReplacementNamed('/');
                isLoggedIn=false;
          } 
            },
            child: Text('Cerrar Sesión'),
          ),
              ],
            ),
        ],
      ),
    );
  }
}
