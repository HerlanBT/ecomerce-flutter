import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/views/model/AppState.dart';

class NavA extends StatefulWidget {
  final int currentPage; // El índice de la página actual

  NavA({Key? key, required this.currentPage}) : super(key: key);

  @override
  _NavAState createState() => _NavAState();
}

class _NavAState extends State<NavA> {
  @override
  Widget build(BuildContext context) {
        final appState = Provider.of<AppState>(context); // Obtén el estado de la aplicación

    // Accede a la variable aux
    final aux = appState.aux;

    return BottomNavigationBar(
      currentIndex: widget.currentPage,
      onTap: (int index) {
        // Aquí puedes determinar qué página debe ir según el índice seleccionado
        if (index == 0) {
        Navigator.pushNamed(context, '/admin');
        } else if (index == 1) {
            Navigator.pushNamed(context, '/carrito');
        } else if (index == 2) {
      if( isLoggedIn){
          
        Navigator.pushNamed(context, '/user',arguments: aux);
      }else{
        Navigator.pushNamed(context, '/login');
      }
        }
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: widget.currentPage == 0
                ? Colors.purple
                : Colors
                    .grey, // Cambia el color del ícono si está en la página de inicio
          ),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            color: widget.currentPage == 1
                ? Colors.purple
                : Colors
                    .grey, // Cambia el color del ícono si está en la página del carrito
          ),
          label: 'Carrito',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: widget.currentPage == 2
                ? Colors.purple
                : Colors
                    .grey, // Cambia el color del ícono si está en la página de perfil
          ),
          label: 'Perfil',
        ),
      ],
    );
  }
}
