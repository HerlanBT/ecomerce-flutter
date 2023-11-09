import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/compras.dart';
import 'package:tienda_god/widgets/drawerUser.dart';
import 'package:tienda_god/widgets/userdatos.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  @override
  Widget build(BuildContext context) {
    print(auxTienda);
    isLoggedIn = true;
    final idUsuario = ModalRoute.of(context)?.settings.arguments as String?;

    return  WillPopScope(
      onWillPop: () async {

        Navigator.popAndPushNamed(context,'/',);
        return false; // Devuelve true si deseas permitir que la acción de retroceso continúe, o false para detenerla
      },
      child: Scaffold(
        drawer: DrawerUser(idUsuario: idUsuario),
        appBar: AppBar(
          title: const Text('Usuario'),
        ),
        body: Column(
          children: [
            Expanded(child: usuario(idUsuario)),
            Container(
              padding: const EdgeInsets.all(10.0), // Añadir un espacio interno
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius:
                    BorderRadius.circular(10.0), // Redondear las esquinas
              ),
              margin: const EdgeInsets.all(10.0),
              child: const Center(
                child: Text(
                  'Tus Compras',
                  style: TextStyle(
                    color: Colors.white, // Cambiar el color del texto a blanco
                    fontSize:
                        20.0, // Cambiar el tamaño de la fuente si es necesario
                  ),
                ),
              ),
            ),
            Expanded(child: ventasPorUsuarioWidget(idUsuario: idUsuario!)),
          ],
        ),
        bottomNavigationBar: Nav(
          currentPage: 2,
        ),
      ),
    );
  }

}