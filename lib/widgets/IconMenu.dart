import 'package:flutter/material.dart';

class IconMenu extends StatelessWidget {
  final IconData icono;
  final String texto;
  final String ruta;

  const IconMenu({
    required this.icono,
    required this.texto,
    Key? key,
    required this.ruta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.blue, // Fondo azul
            shape: CircleBorder(), // Forma circular
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/productos',arguments: ruta);
            },
            icon: Icon(icono, color: Colors.white), // Icono en blanco
          ),
        ),
        Text(texto),
      ],
    );
  }
}
