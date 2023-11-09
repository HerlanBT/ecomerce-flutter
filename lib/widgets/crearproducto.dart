// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/obtenerimagen.dart';
import 'package:tienda_god/services/producto_service.dart';

import 'package:tienda_god/widgets/inputsDeco.dart';

class createproduct extends StatefulWidget {
  final String idusuario;
  const createproduct({super.key, required this.idusuario});

  @override
  State<createproduct> createState() => _createproductState();
}

class _createproductState extends State<createproduct> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario
  File? image_to;

  TextEditingController nombreProducto = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController preciocontroller = TextEditingController();
  TextEditingController cantidadcontroller = TextEditingController();
  TextEditingController tipoProducto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String idTienda = widget.idusuario;
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
                  'Registrar Producto',
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
                            controller: nombreProducto,
                            decoration: InputDecorations.inputDecoration(
                              hintText: 'INGRESE SU NOMBRE',
                              labelText: 'Nombre',
                              icono: Icon(Icons.business_center),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller:
                                descripcion, // Asigna el controlador aquí
                            decoration: InputDecoration(
                              labelText: 'Escribe tu texto aquí',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: cantidadcontroller,
                            decoration: InputDecorations.inputDecoration(
                              hintText: '1-100',
                              labelText: 'Cantidad que su Producto',
                              icono: Icon(Icons.add_circle_outlined),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: preciocontroller,
                            decoration: InputDecorations.inputDecoration(
                              hintText: '00.00',
                              labelText: 'Precio del Producto',
                              icono: Icon(Icons.monetization_on),
                            ),
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
                              SingleChildScrollView(
                                child: Form(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 900,
                                        child: DropdownButtonFormField<String>(
                                          items: tipos_productos
                                              .map((String tipos) {
                                            return DropdownMenuItem<String>(
                                              child: Text(tipos),
                                              value: tipos,
                                            );
                                          }).toList(),
                                          onChanged: (tipos) {
                                            tipoProducto.text = tipos!;
                                          },
                                          decoration:
                                              InputDecorations.inputDecoration(
                                            hintText: 'Tipo de Producto',
                                            labelText: 'Tipo de Producto',
                                            icono: const Icon(
                                                Icons.content_paste_sharp),
                                          ),
                                          style: TextStyle(color: Colors.black),
                                          dropdownColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
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
                              double precio =
                                  double.parse(preciocontroller.text);
                              int cantidad = int.parse(cantidadcontroller.text);
                              await crearProducto(
                                  nombreProducto.text,
                                  descripcion.text,
                                  precio,
                                  cantidad,
                                  tipoProducto.text,
                                  image_to!,
                                  idTienda);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title:  Row(
                                    children: [
                                    const  Text('Exitos',
                                          style: TextStyle(
                                            color: Colors.green,
                                          )),
                                      Container(color:Colors.green , child: const Icon(Icons.check))
                                    ],
                                  ),
                                  content: const Text(
                                      'Producto Registrado Correctamente'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/tienda',
                                          arguments: idTienda),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
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
