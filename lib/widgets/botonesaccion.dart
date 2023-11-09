import 'package:flutter/material.dart';

class buttonacciones extends StatelessWidget {
  final String texto;
  final IconData icono;
  const buttonacciones({
    Key? key,
    required this.texto,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.pushNamed(context, '/admin/$texto' );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: 70.0,
        height: 60.0,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.purple,
              Colors.blueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              BorderRadius.circular(10.0), // Añadir bordes redondeados
          border: Border.all(
            width: 1.0, // Ancho del borde
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                icono,
                color: Colors.white,
                size: 30.0,
              ),
              Text(
                texto,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
