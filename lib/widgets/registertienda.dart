// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/obtenerimagen.dart';
import 'package:tienda_god/services/tienda_service.dart';

import 'package:tienda_god/widgets/inputsDeco.dart';

class registerformtienda extends StatefulWidget {
  final String idusuario;
  registerformtienda({super.key, required this.idusuario});

  @override
  State<registerformtienda> createState() => _registerformtiendaState();
}

class _registerformtiendaState extends State<registerformtienda> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario
  File? image_to;

  TextEditingController nombrecontroller = TextEditingController();
  TextEditingController telefonocontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegExp = RegExp(r'^\d{10}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    String idUser = widget.idusuario;
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
                  'Crear Tienda',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: nombrecontroller,
                            decoration: InputDecorations.inputDecoration(
                              hintText: 'INGRESE SU NOMBRE',
                              labelText: 'Nombre',
                              icono: Icon(Icons.abc_outlined),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, ingrese su nombre';
                              }
                              return null; // La validación pasa
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: telefonocontroller,
                            decoration: InputDecorations.inputDecoration4(
                              hintText: 'Enter your phone number',
                              labelText: 'Phone Number',
                              icono: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, ingrese su número de teléfono';
                              } else if (!isValidPhoneNumber(value)) {
                                return 'Ingrese un número de teléfono válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: passcontroller,
                            decoration: InputDecorations.inputDecoration(
                              hintText: 'Enter your password',
                              labelText: 'Password',
                              icono: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, ingrese su contraseña';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Seleccionar una imagen',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.all(10.0),
                                width: double.infinity,
                                height: 200,
                                child: image_to != null
                                    ? Image.file(image_to!, fit: BoxFit.cover)
                                    : Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    useSafeArea: true,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // Ajusta el tamaño del contenido
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.camera),
                                              title: Text('Tomar Foto'),
                                              onTap: () async {
                                                final image = await getPhoto();
                                                if (image != null) {
                                                  imagenTienda =
                                                      File(image.path);

                                                  setState(() {
                                                    image_to =
                                                        File(image.path.trim());
                                                  });
                                                }
                                                Navigator.of(context)
                                                    .pop(); // Cierra el diálogo
                                              },
                                            ),
                                            Divider(), // Línea divisoria
                                            ListTile(
                                              leading: Icon(Icons.image),
                                              title: Text(
                                                  'Seleccionar de la Galería'),
                                              onTap: () async {
                                                final image = await getImage();
                                                if (image != null) {
                                                  imagenTienda =
                                                      File(image.path.trim());

                                                  setState(() {
                                                    image_to = File(image.path);
                                                  });
                                                }
                                                Navigator.of(context)
                                                    .pop(); // Cierra el diálogo
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text('SELECCIONAR IMAGEN'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String idTienda = await crearTienda(
                                    nombrecontroller.text,
                                    telefonocontroller.text,
                                    passcontroller.text,
                                    image_to!,
                                    idUser);
                                Navigator.pushNamed(context, '/tienda',
                                    arguments: idTienda);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors
                                  .blue, // Color del texto dentro del botón
                              padding:
                                  const EdgeInsets.all(16), // Espaciado interno
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Borde redondeado
                              ),
                            ),
                            child: const Text(
                              'Enviar',
                              style: TextStyle(
                                fontSize: 18, // Tamaño de fuente del texto
                                fontWeight: FontWeight
                                    .bold, // Peso de la fuente (negrita)
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
