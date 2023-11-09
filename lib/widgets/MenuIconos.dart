import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/IconMenu.dart';

class MenuIconos extends StatelessWidget {
  const MenuIconos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        padding: EdgeInsets.all(46.0),
        child: const Wrap(
          alignment: WrapAlignment.center, 
          spacing: 50.0, 
          runSpacing: 8.0, 
          children: [
            IconMenu(icono: Icons.toys, texto: 'Juguetes', ruta: 'Juguetes'),
            IconMenu(icono: Icons.brush_outlined, texto: 'Arte', ruta: 'Arte'),
            IconMenu(icono: Icons.electrical_services,texto: 'Electronica',ruta: 'Electronica'),
            IconMenu(icono: Icons.home_outlined,texto: 'Hogar ',ruta: 'Hogar'),
            IconMenu(icono: Icons.card_travel_sharp,texto: 'Otros ',ruta: 'Otros'),
          
          ],
        ));
  }
}
