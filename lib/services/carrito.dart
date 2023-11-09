import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tienda_god/services/Urls.dart';
class Productocarrito {
  final String idProducto;
  final String nombreProducto;
   double precio;
   int cantidad;
  final int idTienda;

  Productocarrito({
    required this.idProducto,
    required this.nombreProducto,
    required this.precio,
    required this.cantidad,
    required this.idTienda,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_producto': idProducto,
      'nombre_producto': nombreProducto,
      'precio': precio,
      'cantidad': cantidad,
      'id_tienda': idTienda,
    };
  }
}

class Carrito extends ChangeNotifier {
  final String accion;
  final String idUsuario;
  final List<Productocarrito> productos;
  double precio;
  int cantidad;

  Carrito({
    required this.accion,
    required this.idUsuario,
    required this.productos,
    required this.precio,
    required this.cantidad,
  });

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> productosJson =
        productos.map((producto) => producto.toJson()).toList();

    return {
      'accion': accion,
      'id_usuario': idUsuario,
      'productos': productosJson,
      'precio': precio,
      'cantidad': cantidad,
    };
  }

  // Función para agregar un producto al carrito
   void agregarProductoSiNoExiste(Productocarrito producto) {
    if (!productoYaAgregado(producto.idProducto)) {
      productos.add(producto);
      precio+=producto.precio;
      cantidad += producto.cantidad; // Actualiza 'cantidad'
      notifyListeners();
    }
  }

  Productocarrito eliminarProducto(String idProducto) {
    final productoExistente = productos.firstWhere(
      (producto) => producto.idProducto == idProducto,
      orElse: () => Productocarrito(
        idProducto: '',
        nombreProducto: '',
        precio: 0.0,
        cantidad: 0,
        idTienda: -1,
      ),
    );

    if (productoExistente.idProducto != -1) {
      precio -= productoExistente.precio;
      cantidad -= productoExistente.cantidad;
      productos.remove(productoExistente);
      notifyListeners(); // Notifica a los oyentes que el estado ha cambiado
    }

    return productoExistente;
  }

  List<Productocarrito> verCarrito() {
    return productos;
  }
  void vaciarCarrito() {
  productos.clear(); // Elimina todos los productos del carrito
  precio = 0.0; // Reinicia el precio a cero
  cantidad = 0; // Reinicia la cantidad a cero
  notifyListeners(); // Notifica a los oyentes que el estado ha cambiado
}
// Agrega esta función a la clase Carrito
bool productoYaAgregado(String idProducto) {
  return productos.any((producto) => producto.idProducto == idProducto);
}
void aumentarCantidad(String idProducto) {
    final productoExistente = productos.firstWhere(
      (producto) => producto.idProducto == idProducto,
      orElse: () => Productocarrito(
        idProducto: '',
        nombreProducto: '',
        precio: 0.0,
        cantidad: 0,
        idTienda: -1,
      ),
    );

    if (productoExistente.idProducto != '') {
      productoExistente.cantidad++;
      precio += productoExistente.precio;
      cantidad++;
      notifyListeners(); // Notifica a los oyentes que el estado ha cambiado
    }
  }

  void reducirCantidad(String idProducto) {
    final productoExistente = productos.firstWhere(
      (producto) => producto.idProducto == idProducto,
      orElse: () => Productocarrito(
        idProducto: '',
        nombreProducto: '',
        precio: 0.0,
        cantidad: 0,
        idTienda: -1,
      ),
    );

    if (productoExistente.idProducto != '' && productoExistente.cantidad > 1) {
      productoExistente.cantidad--;
      precio -= productoExistente.precio;
      cantidad--;
      notifyListeners(); // Notifica a los oyentes que el estado ha cambiado
    }
  }
}




Future<void> agregarVentaAlServidor(Carrito carrito) async {
  final url = Uri.parse(ventasurl2); 

  final Map<String, dynamic> data = {
    "accion": carrito.accion,
    "id_usuario": aux,
    "productos": carrito.verCarrito().map((producto) => producto.toJson()).toList(),
    "precio": carrito.precio,
    "cantidad": carrito.cantidad,
  };
print(data);
  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse.containsKey("mensaje")) {
      print("Mensaje del servidor: ${jsonResponse["mensaje"]}");
      carrito.vaciarCarrito(); // Si la venta se realizó con éxito, puedes vaciar el carrito
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
    } else {
      print("Respuesta inesperada del servidor");
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }
}


Future<List<Map<String, dynamic>>> ventasPorUsuario(String idUsuario) async {
  final url = Uri.parse('$ventasurl=ventasPorUsuario&id_usuario=$idUsuario');
  final response = await http.get(url);
print(response.body);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List) {
      return List<Map<String, dynamic>>.from(jsonResponse);
    }
  }
  return [];
}
Future<List<Map<String, dynamic>>> productosMenosVendidosPorTienda(String idTienda) async {
  final url = Uri.parse('$ventasurl=productosMenosVendidosPorTienda&id_tienda=$idTienda');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List) {
      return List<Map<String, dynamic>>.from(jsonResponse);
    }
  }
  return [];
}
Future<List<Map<String, dynamic>>> productosMasVendidos() async {
  final url = Uri.parse('$ventasurl=productosMasVendidos');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List) {
      return List<Map<String, dynamic>>.from(jsonResponse);
    }
  }
  return [];
}
Future<List<Map<String, dynamic>>> productosMasVendidosPorTienda(String idTienda) async {
  final url = Uri.parse('$ventasurl=productosMasVendidosPorTienda&id_tienda=$idTienda');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List) {
      return List<Map<String, dynamic>>.from(jsonResponse);
    }
  }
  return [];
}
Future<List<Map<String, dynamic>>> recuperarVentasTienda(String idTienda) async {
  final url = Uri.parse('$ventasurl=recuperarVentasTienda&id_tienda=$idTienda');
  final response = await http.get(url);
print(response.body);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List) {
      return List<Map<String, dynamic>>.from(jsonResponse);
    }
  }
  return [];
}
Future<List<Map<String, dynamic>>> buscarCompras(String correo, String telefono) async {
  final url = Uri.parse('$ventasurl=buscarCompras&correo=$correo&telefono=$telefono');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List) {
      return List<Map<String, dynamic>>.from(jsonResponse);
    }
  }
  return [];
}
Future<List<Map<String, dynamic>>> recuperarVentas() async {
  final url = Uri.parse('$ventasurl=recuperarVentas');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse is List) {
      return List<Map<String, dynamic>>.from(jsonResponse);
    }
  }
  return [];
}
