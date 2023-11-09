import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tienda_god/services/Urls.dart';

Future<String> crearTienda(String nombretienda, String telefono,
    String contrasena, File logourl, String idusuario) async {
  final url = Uri.parse(
      tiendaurl); // Reemplaza con la URL de tu servidor y tu script PHP

  final imageBytes = await logourl.readAsBytes();
  final imageBase64 = base64Encode(imageBytes);

  final Map<String, String> data = {
    "accion": "crearTienda",
    "nombre_tienda": nombretienda,
    "telefono": telefono,
    "contrasena": contrasena,
    "logo_base64": imageBase64, // Envía la imagen como Base64
    "id_usuario": idusuario,
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final id = responseData;
    return id;
  } else {
    final responseData = jsonDecode(response.body);
    print("Error en la solicitud HTTP: $responseData");
    return responseData;
  }
}


Future<String> loginTienda(String nombretienda, String password) async {
  final url = Uri.parse(tiendaurl);

  final Map<String, String> data = {
    "accion": "loginTienda",
    "nombre_tienda": nombretienda,
    "contrasena": password
  };

  final response = await http.post(url, body: jsonEncode(data));
  print(response.body);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData[0] == "Tienda no encontrada.") {
      return "Tienda no encontrada";
    } else if (responseData[0] == "Contrasena incorrecta.") {
      return "Contrasena incorrecta";
    } else {
      final idTienda = responseData['id_tienda'] as String;
      return idTienda;
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
    throw Exception("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

Future<String> recuperarTienda(String nombre,String telefono,String idUsuarioT) async {
  final url = Uri.parse(tiendaurl);

  final Map<String, String> data = {
    "accion": "recuperarTienda",
    "nombre_tienda": nombre,
    "telefono": telefono,
    "id_usuarioT": idUsuarioT,
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData);
    String idTienda=responseData;
    return idTienda;
  } else {
    return"Error en la solicitud HTTP: ${response.statusCode}";
  }
}

Future<void> cambiarContrasenaT(String idUsuarioT,String contranueva) async {
  final url = Uri.parse(tiendaurl);

  final Map<String, String> data = {
    "accion": "cambiarContrasena",
    "id_usuarioT": idUsuarioT,
    "nueva_contrasena": contranueva,
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData); // Maneja la respuesta JSON aquí
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

Future<void> eliminarTienda(String nombre) async {
  final url = Uri.parse(tiendaurl);

  final Map<String, String> data = {
    "accion": "eliminarTienda",
    "nombre_tienda": nombre,
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData); // Maneja la respuesta JSON aquí
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

Future<void> editarTienda(String idUsuarioT, String telefono) async {
  final url = Uri.parse(tiendaurl);

  final Map<String, dynamic> data = {
    "accion": "editarTienda",
    "id_usuarioT": idUsuarioT,
    "telefono": telefono,
   
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(responseData); // Maneja la respuesta JSON aquí
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

Future<List< dynamic>> obtenerTodasLasTiendas() async {
  final url = Uri.parse(tiendaurl);

  final Map<String, String> data = {
    "accion": "obtenerTodasLasTiendas",
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);

        return responseData['tiendas'];
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
        throw Exception("Error en la solicitud HTTP: ${response.statusCode}");
  }
}

Future<Map<String, dynamic>> recuperarTiendaId(String idtienda) async {
  final url = Uri.parse(tiendaurl);

  final Map<String, String> data = {
    "accion": "recuperarTiendaID",
    "id_tienda": idtienda,
  };

  final response = await http.post(url, body: jsonEncode(data));
print(response.body);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData['tienda']; // Devuelve los datos de la tienda
  } else {
    throw Exception("Error en la solicitud HTTP: ${response.statusCode}");
  }
}
