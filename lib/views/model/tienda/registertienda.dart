
import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/widgets/drawerUser.dart';
import 'package:tienda_god/widgets/registertienda.dart';
import 'package:tienda_god/widgets/widgetsForm.dart';


class RegistriarTienda extends StatefulWidget {
  const RegistriarTienda({super.key});

  @override
  State<RegistriarTienda> createState() => _RegistriarTiendaState();
}

class _RegistriarTiendaState extends State<RegistriarTienda> {


  @override
  Widget build(BuildContext context) {
    print(aux);
        final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);
    return Scaffold(
       drawer: DrawerUser(idUsuario: aux),
      appBar: AppBar(
        title: const Text('Crear  Tienda'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
            iconotienda(),
            registerformtienda(idusuario: aux),
          ],
        ),
      ),
    );
  }
}
