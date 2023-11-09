import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/tienda_service.dart';
import 'package:tienda_god/widgets/drawerUser.dart';
import 'package:tienda_god/widgets/inputsDeco.dart';

class CambiarContrasenaTiendaForm extends StatefulWidget {
  @override
  _CambiarContrasenaTiendaFormState createState() =>
      _CambiarContrasenaTiendaFormState();
}

class _CambiarContrasenaTiendaFormState
    extends State<CambiarContrasenaTiendaForm> {
  final TextEditingController _nuevaContrasenaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final idUsuarioT = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      drawer: DrawerUser(idUsuario: aux),
      appBar: AppBar(
        title: const Text('Cambiar Contraseñar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: _nuevaContrasenaController,
              obscureText: true,
              decoration: InputDecorations.inputDecoration(labelText: 'Nueva Contraseña', hintText: 'Nueva Contraseña', icono: Icon(Icons.lock_rounded),),
            ),
            ElevatedButton(
              onPressed: () async {
                // Aquí puedes realizar la lógica para cambiar la contraseña en el servidor
                final nuevaContrasena = _nuevaContrasenaController.text;

                cambiarContrasenaT(idUsuarioT, nuevaContrasena);
                await Navigator.pushNamed(context, '/tienda',
                    arguments: idUsuarioT);
              },
              child: Text('Cambiar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
