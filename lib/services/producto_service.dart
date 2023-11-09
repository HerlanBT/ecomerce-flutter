import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tienda_god/services/Urls.dart';
import 'dart:convert';

import 'package:tienda_god/views/model/producto/producto.dart';

Future<List<Producto>> obtenerProductos() async {
  final url = Uri.parse(productosurl);
  final Map<String, dynamic> data = {
    "accion": "obtenerproductos",
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> productosJson = jsonResponse["productos"];

    // Mapear los datos JSON a objetos Producto
    List<Producto> productos = productosJson.map((productoJson) {
      return Producto(
        id: int.parse(productoJson["id"]),
        idProducto: productoJson["id_producto"],
        nombreProducto: productoJson["nombre_producto"],
        descripcion: productoJson["descripcion"],
        precio: double.parse(productoJson["precio"]),
        cantidad: int.parse(productoJson["cantidad"]),
        tipoProducto: productoJson["tipo_producto"],
        imagenUrl: productoJson["imagen_url"],
        idTienda: int.parse(productoJson["id_tienda"]),
        fechaProducto: DateTime.parse(productoJson["fecha_producto"]),
      );
    }).toList();

    print("Productos: $productos");

    return productos;
  } else {
    // Hubo un error en la solicitud HTTP
    print("Error en la solicitud HTTP: ${response.statusCode}");
    throw Exception("Error en la solicitud HTTP");
  }
}

Future<List<Producto>> obtenerProductosDiferentes() async {
  final url = Uri.parse(productosurl);
  final Map<String, dynamic> data = {
    "accion": "obtenerproductosdiferentes",
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> productosJson = jsonResponse["productos"];

    // Mapear los datos JSON a objetos Producto
    List<Producto> productos = productosJson.map((productoJson) {
      return Producto(
        id: int.parse(productoJson["id"]),
        idProducto: productoJson["id_producto"],
        nombreProducto: productoJson["nombre_producto"],
        descripcion: productoJson["descripcion"],
        precio: double.parse(productoJson["precio"]),
        cantidad: int.parse(productoJson["cantidad"]),
        tipoProducto: productoJson["tipo_producto"],
        imagenUrl: productoJson["imagen_url"],
        idTienda: int.parse(productoJson["id_tienda"]),
        fechaProducto: DateTime.parse(productoJson["fecha_producto"]),
      );
    }).toList();

    print("Productos: $productos");

    return productos;
  } else {
    // Hubo un error en la solicitud HTTP
    print("Error en la solicitud HTTP: ${response.statusCode}");
    throw Exception("Error en la solicitud HTTP");
  }
}

//Crear Producto
Future<void> crearProducto(
    String nombreProducto,
    String descripcion,
    double precio,
    int cantidad,
    String tipoProducto,
    File imagenUrl,
    String idTienda) async {
  final url = Uri.parse(productosurl);
  final imageBytes = await imagenUrl.readAsBytes();
  final imageBase64 = base64Encode(imageBytes);

  final Map<String, dynamic> data = {
    "accion": "crearProducto",
    "nombre_producto": nombreProducto,
    "descripcion": descripcion,
    "precio": precio,
    "cantidad": cantidad,
    "tipo_producto": tipoProducto,
    "imagen_url": imageBase64,
    "id_tienda": idTienda
  };
  print(data);
  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

//Recuperar por Tienda
Future<List<Producto>> recuperarProductosPorTienda(String idtienda) async {
  final url = Uri.parse(productosurl);
  final Map<String, dynamic> data = {
    "accion": "recuperarProductosPorTienda",
    "id_tienda": idtienda
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey("productos")) {
      final List<dynamic> productosJson = jsonResponse["productos"];
      List<Producto> productos = productosJson.map((productoJson) {
        return Producto(
          id: int.parse(productoJson["id"]),
          idProducto: productoJson["id_producto"],
          nombreProducto: productoJson["nombre_producto"],
          descripcion: productoJson["descripcion"],
          precio: double.parse(productoJson["precio"]),
          cantidad: int.parse(productoJson["cantidad"]),
          tipoProducto: productoJson["tipo_producto"],
          imagenUrl: productoJson["imagen_url"],
          idTienda: int.parse(productoJson["id_tienda"]),
          fechaProducto: DateTime.parse(productoJson["fecha_producto"]),
        );
      }).toList();
      return productos;
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
      return [];
    } else {
      print("Respuesta inesperada del servidor");
      return [];
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
    return [];
  }
}

//Editar Producto
Future<void> editarProducto(String nombreProducto, String descripcion,
    double precio, int cantidad, String idProducto) async {
  final url = Uri.parse(productosurl);
  final Map<String, dynamic> data = {
    "accion": "editarProducto",
    "nombre_producto": nombreProducto,
    "descripcion": descripcion,
    "precio": precio,
    "cantidad": cantidad,
    "id_producto": idProducto,
  };
print(data);
  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey("mensaje")) {
      print("Mensaje del servidor: ${jsonResponse["mensaje"]}");
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
    } else {
      print("Respuesta inesperada del servidor");
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

//Elimar Producto
Future<void> eliminarProducto(String idProducto) async {
  final url = Uri.parse(productosurl);
  final Map<String, dynamic> data = {
    "accion": "eliminarProducto",
    "id_producto": idProducto,
  };

  final response = await http.post(url, body: jsonEncode(data));
  print(response);
  print("Eliminando producto con ID: $idProducto");
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey("mensaje")) {
      print("Mensaje del servidor: ${jsonResponse["mensaje"]}");
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
    } else {
      print("Respuesta inesperada del servidor");
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

Future<Map<String, dynamic>> recuperarProductoPorID(String idProducto) async {
  final String url = productosurl; // Reemplaza con la URL de tu servidor
  final Map<String, dynamic> data = {
    'accion': 'recuperarProductoporID',
    'id_producto': idProducto,
  };

  final response = await http.post(Uri.parse(url), body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final producto = jsonResponse['productos']
        [0]; // Accede al primer elemento del array "productos"
    return producto;
  } else {
    throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
  }
}

Future<List<Producto>> obtenerProductosPorTipo(String tipoproducto) async {
  final String url = productosurl; // Reemplaza con la URL de tu servidor
  final Map<String, dynamic> data = {
    'accion': 'obtenerProductosPorTipo',
    'tipo_producto': tipoproducto,
  };

  final response = await http.post(Uri.parse(url), body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final productosJson = jsonResponse['productos'] as List<dynamic>;

    final productos = productosJson.map((productoJson) {
      return Producto(
        id: int.parse(productoJson['id'] as String),
        idProducto: productoJson['id_producto'] as String,
        nombreProducto: productoJson['nombre_producto'] as String,
        descripcion: productoJson['descripcion'] as String,
        precio: double.parse(productoJson['precio'] as String),
        cantidad: int.parse(productoJson['cantidad'] as String),
        tipoProducto: productoJson['tipo_producto'] as String,
        imagenUrl: productoJson['imagen_url'] as String,
        idTienda: int.parse(productoJson['id_tienda'] as String),
        fechaProducto: DateTime.parse(productoJson["fecha_producto"]),
      );
    }).toList();

    return productos;
  } else {
    throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
  }
}
