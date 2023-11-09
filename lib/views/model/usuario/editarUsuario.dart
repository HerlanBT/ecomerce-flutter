import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/drawerUser.dart';
import 'package:tienda_god/widgets/editUser.dart';

import 'package:tienda_god/widgets/widgetsForm.dart';

class EditarUserView extends StatefulWidget {
  final String idUser;

  EditarUserView({required this.idUser});

  @override
  State<EditarUserView> createState() => _EditarUserViewState();
}

class _EditarUserViewState extends State<EditarUserView> {
  @override
  Widget build(BuildContext context) {
    final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);

    print(widget.idUser);

    String idTienda = widget.idUser;
    return Scaffold(
      drawer:DrawerUser(),
      appBar: AppBar(
        title: Text('Editar Usuario'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
            editUser(
              idUser: idTienda,
            )
          ],
        ),
      ),
    );
  }
}
