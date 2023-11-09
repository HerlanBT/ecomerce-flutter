import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tienda_god/services/Urls.dart';

//Crear Usuario
Future<String> crearUsuario(String nombre, String apellido, String correo,
    String password, String telefono) async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "createUSU",
    "nombre": nombre,
    "apellido": apellido,
    "correo": correo,
    "password": password,
    "telefono": telefono,
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    if (jsonResponse.containsKey("id_usuario")) {
      String idUsuario = jsonResponse["id_usuario"];

      return idUsuario;
    } else {
      return "La respuesta del servidor no contiene un campo 'id_usuario'.";
    }
  } else {
    return "Error en la solicitud HTTP: ${response.statusCode}";
  }
}

//Iniciar Session
Future<String?> iniciarSesion(String correo, String password) async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "login",
    "correo": correo,
    "password": password,
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey("mensaje")) {
      print("Mensaje del servidor: ${jsonResponse["mensaje"]}");
      final idUsuario = jsonResponse["id_usuario"];
      return idUsuario; // Devuelve el ID de usuario
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
      return null; // Devuelve null en caso de error
    } else {
      print("Respuesta inesperada del servidor");
      return null; // Devuelve null en caso de respuesta inesperada
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
    return null; // Devuelve null en caso de error de solicitud HTTP
  }
}

//Cerrar Session
Future<bool> cerrarSesion() async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "logout",
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey("mensaje")) {
      print("Mensaje del servidor: ${jsonResponse["mensaje"]}");
      auxTienda="--";
      return true;
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
      return false;
    } else {
      print("Respuesta inesperada del servidor");
      return false;
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
    return false;
  }
}

//Recuperar Usuario
Future<String> recuperarUsuario(
    String correo, String nombre, String apellido, String telefono) async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "recuperarUsuario",
    "correo": correo,
    "nombre": nombre,
    "apellido": apellido,
    "telefono": telefono,
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
String idUsuario=jsonResponse;

    return idUsuario;
  } else {
    return"Error en la solicitud HTTP: ${response.statusCode}";
  }
}

//Cambiar Contraseña
Future<void> cambiarContrasena(String idUsuario, String nuevaContrasena) async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "cambiarContrasena",
    "id_usuario": idUsuario,
    "nueva_contrasena": nuevaContrasena,
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

//Elimar Usuario
Future<void> eliminarUsuario(String idUsuario) async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "eliminarUsuario",
    "id_usuario": idUsuario,
  };

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

//Editar Usuario
Future<void> editarUsuario(String idUsuario,
    {String? nombre,
    String? apellido,
    String? correo,
    String? telefono}) async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "editarUsuario",
    "id_usuario": idUsuario,
  };

  if (nombre != null) {
    data["nombre"] = nombre;
  }

  if (apellido != null) {
    data["apellido"] = apellido;
  }

  if (correo != null) {
    data["correo"] = correo;
  }

  if (telefono != null) {
    data["telefono"] = telefono;
  }
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

//Obtener Usuario
Future<List<dynamic>> obtenerUsuarios() async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "obtenerUsuarios",
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey("usuarios")) {
      return jsonResponse["usuarios"];
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
    } else {
      print("Respuesta inesperada del servidor");
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }

  return [];
}

//Obtener Usuario
Future<Map<String, dynamic>> obtenerUsuario(String? id_usuario) async {
  final url = Uri.parse(usuariosurl);
  final Map<String, dynamic> data = {
    "accion": "obtenerUsuario",
    "id_usuario": id_usuario
  };

  final response = await http.post(url, body: jsonEncode(data));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey("Usuario Encontrado")) {
      return jsonResponse["Usuario Encontrado"]
          [0]; // Devuelve el primer usuario encontrado como mapa
    } else if (jsonResponse.containsKey("error")) {
      print("Error del servidor: ${jsonResponse["error"]}");
    } else {
      print("Respuesta inesperada del servidor");
    }
  } else {
    print("Error en la solicitud HTTP: ${response.statusCode}");
  }

  return {};
}
