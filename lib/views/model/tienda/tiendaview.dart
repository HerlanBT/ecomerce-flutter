import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/TiendaWidget.dart';
import 'package:tienda_god/widgets/drawerTienda.dart';
import 'package:tienda_god/widgets/listaproductostienda.dart';

class TiendaView extends StatefulWidget {
  const TiendaView({Key? key}) : super(key: key);

  @override
  State<TiendaView> createState() => _TiendaViewState();
}

class _TiendaViewState extends State<TiendaView> {
  @override
  Widget build(BuildContext context) {
    final idTienda = ModalRoute.of(context)?.settings.arguments as String;
    auxTienda=idTienda;
    return WillPopScope(
        onWillPop: () async {
        // Define la lógica de navegación al presionar el botón de "volver" aquí
        // Por ejemplo, puedes navegar a otra ruta o realizar otras acciones
              Navigator.popAndPushNamed(context, '/user',
                                  arguments: aux);
        return false; // Devuelve true si deseas permitir que la acción de retroceso continúe, o false para detenerla
      },
      child: Scaffold(
        drawer: DrawerTienda(idTienda: idTienda,),
        appBar: AppBar(title: Text('Tienda')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TiendaWidget(idTienda: idTienda),
            Container(
              padding: const EdgeInsets.all(10.0), // Añadir un espacio interno
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius:
                    BorderRadius.circular(10.0), // Redondear las esquinas
              ),
              margin: const EdgeInsets.all(10.0),
              child:const Center(
                child: Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.white, // Cambiar el color del texto a blanco
                    fontSize:
                        20.0, // Cambiar el tamaño de la fuente si es necesario
                  ),
                ),
              ),
            ),
            Expanded(
              child: ProductosLista(idtienda: idTienda),
            ),
          ],
        ),
          bottomNavigationBar: Nav(
          currentPage: 2,
        ),
      ),
    );
  }
}
