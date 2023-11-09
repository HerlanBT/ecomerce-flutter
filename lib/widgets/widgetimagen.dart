import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/obtenerimagen.dart';

class imagenInput extends StatefulWidget {
  const imagenInput({super.key});

  @override
  State<imagenInput> createState() => _imagenInputState();
}

class _imagenInputState extends State<imagenInput> {
  File? image_to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Seleccionar una imagen',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    mainAxisSize:
                        MainAxisSize.min, // Ajusta el tamaño del contenido
                    children: [
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text('Tomar Foto'),
                        onTap: () async {
                          final image = await getPhoto();
                          if (image != null) {
                             imagenTienda = File(image.path);
                       
                            setState(() {
                              image_to = File(image.path.trim());
                            });
                          }
                          Navigator.of(context).pop(); // Cierra el diálogo
                        },
                      ),
                      Divider(), // Línea divisoria
                      ListTile(
                        leading: Icon(Icons.image),
                        title: Text('Seleccionar de la Galería'),
                        onTap: () async {
                          final image = await getImage();
                          if (image != null) {
                            imagenTienda = File(image.path.trim());
                             
                            setState(() {
                              image_to = File(image.path);
                            });
                          }
                          Navigator.of(context).pop(); // Cierra el diálogo
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
    );
  }
}
