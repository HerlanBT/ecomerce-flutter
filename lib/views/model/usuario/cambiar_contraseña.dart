import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/usuario_service.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';
import 'package:tienda_god/widgets/inputsDeco.dart';

class CambiarContrasenaForm extends StatefulWidget {
  const CambiarContrasenaForm({Key? key}) : super(key: key);

  @override
  _CambiarContrasenaFormState createState() => _CambiarContrasenaFormState();
}

class _CambiarContrasenaFormState extends State<CambiarContrasenaForm> {
  final TextEditingController _nuevaContrasenaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final idUsuario = ModalRoute.of(context)?.settings.arguments as String;
    return  WillPopScope(
      onWillPop: () async {
        // Define la lógica de navegación al presionar el botón de "volver" aquí
        // Por ejemplo, puedes navegar a otra ruta o realizar otras acciones
        Navigator.popAndPushNamed(context,'/login',);
        return false; // Devuelve true si deseas permitir que la acción de retroceso continúe, o false para detenerla
      },
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: const Text('Cambiar Contraseña')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              TextFormField(
                controller: _nuevaContrasenaController,
                obscureText: true, // Para ocultar la contraseña
                decoration: InputDecorations.inputDecoration(
                  labelText: 'Nueva Contraseña',icono: Icon(Icons.lock_rounded),hintText: 'Ingrese Nueva Contraseña'
                ),
                validator: (value) {
                  // Agrega validación personalizada aquí si es necesario
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la nueva contraseña';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes enviar la solicitud para cambiar la contraseña
                  final nuevaContrasena = _nuevaContrasenaController.text;
                  cambiarContrasena(idUsuario, nuevaContrasena);
                  Navigator.pushReplacementNamed(context, '/user', arguments: idUsuario);
                  aux = idUsuario;
                },
                child: Text('Cambiar Contraseña'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Nav(currentPage: 2),
      ),
    );
  }
}
