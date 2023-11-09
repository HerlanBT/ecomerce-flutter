import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/services/tienda_service.dart';
import 'package:tienda_god/services/usuario_service.dart';
import 'package:tienda_god/views/model/tienda/editarTienda.dart';
import 'package:tienda_god/views/model/tienda/ventas.dart';

class DrawerTienda extends StatefulWidget {
  final String idTienda;
  const DrawerTienda({Key? key, required this.idTienda}) : super(key: key);

  @override
  State<DrawerTienda> createState() => _DrawerTiendaState();
}

class _DrawerTiendaState extends State<DrawerTienda> {
  Map<String, dynamic> usuario = {}; // Almacena los datos del usuario aquí

  @override
  void initState() {
    super.initState();

    if (isLoggedIn) {
      // Si el usuario ha iniciado sesión, obtén sus datos

      recuperarTiendaId(widget.idTienda).then((data) {
        setState(() {
          usuario = data;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<Carrito>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: isLoggedIn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Bienvenido, ${usuario["nombre_tienda"] ?? "Usuario"}'),
                      SizedBox(height: 10),
                      Text(
                          'Tienda: ${usuario["id_tienda"] ?? "Correo no disponible"}'),
                      // Otros campos del usuario que quieras mostrar
                    ],
                  )
                : Text('Mi App'),
          ),
          if (isLoggedIn)
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.add_business_rounded),
                  title: Text('Agregar Productos'),
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/productos/añadir',
                        arguments: widget.idTienda);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('Tus Ventas'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => VentasScrean(
                          idTienda1: widget.idTienda,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.store_mall_directory),
                  title: Text('Tu Tienda'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/tienda',arguments: widget.idTienda);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Editar Tienda'),
                  onTap: () {
                   Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (BuildContext context) =>
                                    EditarTiendaView(idTienda: widget.idTienda),
                             ),
                           );
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await cerrarSesion()) {
                      auxTienda = '---';

                      Navigator.of(context).pushReplacementNamed('/tienda/login',arguments: aux);
                      
                     
                               
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
                aux = '';
                carrito.vaciarCarrito();
                Navigator.pushNamed(context, '/login');
              },
            ),
        ],
      ),
    );
  }
}
