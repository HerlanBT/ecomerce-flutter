// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class listaTipoPrd extends StatelessWidget {
  const listaTipoPrd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceEvenly, // Opcional: Alineación de los elementos en la fila
        children: [
          // Elementos de la fila
          elementos(
            ruta: 'Juguetes',
          ),
          elementos(
            ruta: 'Arte',
          ),
          elementos(
            ruta: 'Electronica',
          ),
          elementos(
            ruta: 'Hogar',
          ),
          elementos(
            ruta: 'Otros',
          ),
        ],
      ),
    );
  }
}

class elementos extends StatelessWidget {
  final String ruta;
  const elementos({
    super.key,
    required this.ruta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      child: ListTile(
        title: Center(
          child: Text(
            ruta,
            style: TextStyle(
              fontSize: 15.0, // Tamaño de fuente personalizado
              fontWeight: FontWeight.bold, // Estilo de fuente en negrita
            ),
          ),
        ),
        onTap: () {
          Navigator.popAndPushNamed(context, '/productos', arguments: ruta);
        },
      ),
    );
  }
}
