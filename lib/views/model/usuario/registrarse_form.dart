import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';
import 'package:tienda_god/widgets/registeruser.dart';
import 'package:tienda_god/widgets/widgetsForm.dart';

class RegistroUsuarioForm extends StatefulWidget {
  const RegistroUsuarioForm({Key? key}) : super(key: key);

  @override
  _RegistroUsuarioFormState createState() => _RegistroUsuarioFormState();
}

class _RegistroUsuarioFormState extends State<RegistroUsuarioForm> {
  @override
  Widget build(BuildContext context) {
    final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);
    return WillPopScope(
      onWillPop: () async {
        // Define la lógica de navegación al presionar el botón de "volver" aquí
        // Por ejemplo, puedes navegar a otra ruta o realizar otras acciones
        Navigator.popAndPushNamed(context,'/login',);
        return false; // Devuelve true si deseas permitir que la acción de retroceso continúe, o false para detenerla
      },
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: const Text('Registrarse')),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              cajapupura(Size.infinite, color1, color2),
              iconopersona(),
              registerformuser(context),
            ],
          ),
        ),
        bottomNavigationBar: Nav(currentPage: 2),
      ),
    );
  }
}
