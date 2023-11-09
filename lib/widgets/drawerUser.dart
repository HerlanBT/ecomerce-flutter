import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/services/usuario_service.dart';
import 'package:tienda_god/views/model/usuario/compras.dart';
import 'package:tienda_god/views/model/usuario/editarUsuario.dart';

class DrawerUser extends StatefulWidget {
  final String? idUsuario;
  const DrawerUser({Key? key, this.idUsuario}) : super(key: key);

  @override
  State<DrawerUser> createState() => _DrawerUserState();
}

class _DrawerUserState extends State<DrawerUser> {
  Map<String, dynamic> usuario = {}; // Almacena los datos del usuario aquí

  @override
  void initState() {
    super.initState();

    if (isLoggedIn) {
      // Si el usuario ha iniciado sesión, obtén sus datos

      obtenerUsuario(widget.idUsuario).then((data) {
        setState(() {
          usuario = data;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(auxTienda);
    final carrito = Provider.of<Carrito>(context);
    final String? idUser = widget.idUsuario;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: isLoggedIn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bienvenido, ${usuario["nombre"] ?? "Usuario"}'),
                      SizedBox(height: 10),
                      Text(
                          'Correo: ${usuario["correo_electronico"] ?? "Correo no disponible"}'),
                      // Otros campos del usuario que quieras mostrar
                    ],
                  )
                : Text('Mi App'),
          ),
          if (isLoggedIn)
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.store_mall_directory),
                  title: Text('Tu Tienda'),
                  onTap: () {
                    if (auxTienda != '') {
                      // Navegar a una ruta
                      Navigator.of(context).pushReplacementNamed('/tienda',
                          arguments: auxTienda);
                    } else {
                      // Navegar a otra ruta
                      Navigator.of(context).pushReplacementNamed(
                          '/tienda/login',
                          arguments: idUser);
                    }
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
                            ComprasScrean(idUsuario1: idUser!),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Editar'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EditarUserView(idUser: idUser!)),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await cerrarSesion()) {
                      Navigator.of(context).pushReplacementNamed('/');
                      aux = ' ';
                      isLoggedIn = false;
                    }
                  },
                  child: Text('Cerrar Sesión'),
                ),
              ],
            ),
          if (!isLoggedIn)
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Iniciar Sesión'),
              onTap: () {
                print(aux);

                print(aux);
                carrito.vaciarCarrito();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
        ],
      ),
    );
  }
}
