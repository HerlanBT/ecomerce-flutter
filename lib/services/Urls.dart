

import 'dart:io';

String host='https://prtgrado.000webhostapp.com';
String host2='http://127.0.0.1';

String imagenes='https://prtgrado.000webhostapp.com/CRUD/';

String productosurl='$host/CRUD/producto.php';
String usuariosurl='$host/CRUD/usuario.php';
String tiendaurl='$host/CRUD/tienda.php';
String productosurl2='$host2/CRUD/producto.php';
String usuariosurl2='$host2/CRUD/usuario.php';
String ventasurl='$host/CRUD/ventas.php?accion';
String ventasurl2='$host/CRUD/ventas.php';
late bool isLoggedIn=false;
late String iduseraux=' ';
late String aux='';

File? imagenTienda;

List<String> tipos_productos=['Juguetes','Electronica','Hogar','Arte','Otros'];

String auxTienda='';