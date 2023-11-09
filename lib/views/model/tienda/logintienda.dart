import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawerUser.dart';

import 'package:tienda_god/widgets/formloginTienda.dart';
import 'package:tienda_god/widgets/widgetsForm.dart';

class LoginTienda extends StatefulWidget {
  const LoginTienda({Key? key}) : super(key: key);

  @override
  State<LoginTienda> createState() => _LoginTiendaState();
}

class _LoginTiendaState extends State<LoginTienda> {
  @override
  Widget build(BuildContext context) {
    final color1 = Color.fromARGB(255, 10, 8, 100);
    final color2 = Color.fromARGB(255, 6, 97, 133);
    return Scaffold(
            drawer: DrawerUser(idUsuario: aux),
      appBar: AppBar(
        title: const Text('Login Tienda'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
            iconoproducto(),
            loginformTienda(context),
          ],
        ),
      ),
      bottomNavigationBar: Nav(
        currentPage: 2,
      ),
    );
  }
}
