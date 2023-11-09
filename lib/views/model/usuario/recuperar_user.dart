// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';
import 'package:tienda_god/widgets/recuperaruser.dart';
import 'package:tienda_god/widgets/widgetsForm.dart';

class RecuperarUsuarioForm extends StatefulWidget {
  const RecuperarUsuarioForm({Key? key}) : super(key: key);

  @override
  _RecuperarUsuarioFormState createState() => _RecuperarUsuarioFormState();
}

class _RecuperarUsuarioFormState extends State<RecuperarUsuarioForm> {

  @override
  Widget build(BuildContext context) {
        final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);
    return Scaffold(
         drawer: MyDrawer(),
      appBar: AppBar(title: const Text('Registrarse')),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
            iconopersona(),
            recuperaruserform(context),
          ],
        ),
      ),
      bottomNavigationBar: Nav(currentPage: 2),
    );
  }
}
