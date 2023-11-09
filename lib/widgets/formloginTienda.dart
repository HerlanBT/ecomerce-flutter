// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/tienda_service.dart';
import 'package:tienda_god/widgets/inputsDeco.dart';

SingleChildScrollView loginformTienda(BuildContext context) {
  final TextEditingController _nombreTienda = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
    final idUsuario = ModalRoute.of(context)?.settings.arguments as String;
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
                'Ingresa a tu Tienda',
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
                        controller: _nombreTienda,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Nombre Tienda',
                          labelText: 'Nombre de la Tienda',
                          icono: const Icon(Icons.store_mall_directory),
                        ),
                        validator: (value) {
                          String pattern = '';
                          RegExp regExp = RegExp(pattern);

                          if (value == 'admin') {
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
                                  (value == "admin" || value.length >= 6))
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
                          final idTienda =
                              await loginTienda(_nombreTienda.text, _passwordController.text);

                          if (idTienda == "Tienda no encontrada") {
                            showAboutDialog(
                              context: context,
                              children: [Text('Tienda no encontrada')],
                            );
                            print("Tienda no encontrada.");
                          } else if (idTienda == "Contrasena incorrecta") {
                            showAboutDialog(
                              context: context,
                              children: [Text('Contraseña incorrecta')],
                            );
                            print('Contraseña incorrecta');
                          } else {
                            // showDialog(
                            //   context: context,
                            //   useSafeArea:
                            //       true, // Asegura que el diálogo esté dentro del área segura del dispositivo

                            //   builder: (context) {
                            //     return AlertDialog(
                            //       contentPadding: const EdgeInsets.all(
                            //           20), // Agrega espacio interno al contenido
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(
                            //             15), // Agrega bordes redondeados
                            //       ),
                            //       title: const Icon(
                            //         Icons.check,
                            //         color: Colors
                            //             .green, // Cambia el color del icono
                            //         size: 40, // Cambia el tamaño del icono
                            //       ),
                            //       content: const Text(
                            //         'Correcto',
                            //         style: TextStyle(
                            //           fontSize:
                            //               18, // Cambia el tamaño del texto
                            //           fontWeight: FontWeight
                            //               .bold, // Cambia la fuente en negrita
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: const Text(
                            //             'OK',
                            //             style: TextStyle(
                            //               color: Colors
                            //                   .green, // Cambia el color del botón OK
                            //               fontSize:
                            //                   18, // Cambia el tamaño del texto del botón
                            //             ),
                            //           ),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //           },
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                             auxTienda=idTienda;
                            Navigator.popAndPushNamed(context, '/tienda',arguments: idTienda);
                            print(auxTienda);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/tienda/recuperar-tienda',arguments: idUsuario);
                          },
                          child: const Text('Olvidaste tu Contraseña')),

                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                       
                            Navigator.pushNamed(
                                context, '/tienda/register');
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
