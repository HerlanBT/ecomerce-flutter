import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/services/usuario_service.dart';
import 'package:tienda_god/views/model/usuario/compras.dart';

class MyDrawer extends StatefulWidget {
  // Variable para controlar el estado de inicio de sesión

  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
   
  @override
  Widget build(BuildContext context) {
      final carrito = Provider.of<Carrito>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: isLoggedIn
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bienvenido, Nombre de Usuario'),
                      SizedBox(height: 10),
                    ],
                  )
                : Text('Mi App'),
          ),
          if (isLoggedIn) // Mostrar elementos solo cuando el usuario ha iniciado sesión
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Tu Tienda'),
                  onTap: () {
                      Navigator.of(context).pushReplacementNamed('/tienda/login');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('Tus Compras'),
                  onTap: () {
                     Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (BuildContext context) =>
                                    ComprasScrean(idUsuario1: aux),
                             ),
                           );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Tu Perfil'),
                  onTap: () {
                    // Acción al hacer clic en "Tu Perfil"
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
     
          if (!isLoggedIn) // Mostrar "Iniciar Sesión" solo si no ha iniciado sesión
          
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Iniciar Sesión'),
              onTap: () {
                print(aux);
                aux='';
                 print(aux);
                  carrito.vaciarCarrito();
                Navigator.pushNamed(context, '/login');
              },
            ),
        ],
      ),
    );
  }
}
