// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/usuario_service.dart';
import 'package:tienda_god/views/model/AppState.dart';
import 'package:tienda_god/widgets/inputsDeco.dart';

SingleChildScrollView loginform(BuildContext context) {
  final appState =
      Provider.of<AppState>(context, listen: false); // Obtener el estado global

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  return SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(
          height: 140,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Iniciar Sesión',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      // Correo
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'example@gmail.com',
                          labelText: 'Correo Electrónico',
                          icono: const Icon(Icons.alternate_email_rounded),
                        ),
                        validator: (value) {
                          String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          RegExp regExp = RegExp(pattern);

                          if (value == 'admin' || value == "?admin") {
                            return null;
                          }

                          return regExp.hasMatch(value ?? '')
                              ? null
                              : 'El valor ingresado no es un correo válido.';
                        },
                      ),
                      const SizedBox(height: 30),
                      // Contraseña
                      TextFormField(
                        controller: _passwordController,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecorations.inputDecoration(
                          hintText: '********',
                          labelText: 'Contraseña',
                          icono: const Icon(Icons.lock_outline),
                        ),
                        validator: (value) {
                          return (value != null &&
                                  (value == "?admin" ||
                                      value == "admin" ||
                                      value.length >= 6))
                              ? null
                              : 'La contraseña debe tener al menos 6 caracteres.';
                        },
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(height: 20),

                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledColor: Colors.grey,
                        color: Colors.deepPurple,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 5,
                          ),
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          if (_emailController.text == '?admin' &&
                              _passwordController.text == '?admin') {
                                print(_emailController.text);
                                print(_passwordController.text);
                            Navigator.popAndPushNamed(context, '/admin');
                          } else {
                            String? idUsuario = await iniciarSesion(
                                _emailController.text,
                                _passwordController.text);
                            aux = idUsuario!;
                            if (idUsuario != null) {
                              appState.updateAux(
                                  idUsuario); // Actualizar aux con el valor de idUsuario

                              isLoggedIn = true;

                              Navigator.popAndPushNamed(context, '/user',
                                  arguments: aux);
                            } else {
                              isLoggedIn = false;
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/user/recuperar-user');
                          },
                          child: const Text('Olvidaste tu Contraseña')),

                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/user/registrarse');
                          },
                          child: const Text('Registrarse')),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  );
}
