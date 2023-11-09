// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/carrito.dart';
import 'package:tienda_god/views/admin.dart';
import 'package:tienda_god/views/carrito.dart';
import 'package:tienda_god/views/home.dart';
import 'package:tienda_god/views/login.dart';
import 'package:tienda_god/views/model/AppState.dart';
import 'package:tienda_god/views/model/admin/tiendasview.dart';
import 'package:tienda_god/views/model/admin/usuariosview.dart';
import 'package:tienda_god/views/model/admin/vetasview.dart';
import 'package:tienda_god/views/model/producto/crearProducto.dart';
import 'package:tienda_god/views/model/producto/productodetalle.dart';
import 'package:tienda_god/views/model/tienda/Contrase%C3%B1aTienda.dart';
import 'package:tienda_god/views/model/tienda/logintienda.dart';
import 'package:tienda_god/views/model/tienda/recuperarTienda.dart';
import 'package:tienda_god/views/model/tienda/registertienda.dart';
import 'package:tienda_god/views/model/tienda/tiendaview.dart';
import 'package:tienda_god/views/model/usuario/cambiar_contrase%C3%B1a.dart';
import 'package:tienda_god/views/model/usuario/recuperar_user.dart';
import 'package:tienda_god/views/model/usuario/registrarse_form.dart';
import 'package:tienda_god/views/model/usuario/user.dart';
import 'package:provider/provider.dart';
import 'package:tienda_god/views/productosview.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(
          create: (context) => Carrito(
            // Inicializa el carrito con los datos necesarios
            accion: 'agregarVenta',
            idUsuario: aux, // Reemplaza con el ID de usuario correcto
            productos: [],
            precio: 0.0,
            cantidad: 0,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicacion Ventas',
      theme: ThemeData(
        primarySwatch: Colors.purple,

      ),
     initialRoute: isLoggedIn ? '/user' : '/', // Verificar si el usuario está conectado
      
     routes: {
      '/':(context) => Home(),
      '/login':(context) => Login(),
      '/user':(context) => UsuarioScreen(),
      '/user/recuperar-user':(context) => RecuperarUsuarioForm(),
      '/user/registrarse':(context) => RegistroUsuarioForm(),
      '/user/cambiar-contreseña':(context) => CambiarContrasenaForm(),
      '/tienda':(context) => TiendaView(),
      '/tienda/register':(context) => RegistriarTienda(),
      '/tienda/login':(context) => LoginTienda(),
      '/tienda/recuperar-tienda':(context) => RecuperarTiendaForm(),
      '/tienda/cambiar-contraseña':(context) => CambiarContrasenaTiendaForm(),
      '/productos':(context) => ProductosVenta(),
      '/producto':(context) => ProductoView(),
      '/carrito':(context) => CarritoWidget(),
      '/productos/añadir':(context) => CrearProducto(),
      '/admin':(context) => Admin(),
      '/admin/Tiendas':(context) => TiendasView(),
      '/admin/Usuarios':(context) => UsuariosView(),
      '/admin/Ventas':(context) => VentasView(),
     },
    );
  }
}