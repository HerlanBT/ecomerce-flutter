class Usuario {
  final int id;
  final String nombre;
  final String apellido;
  final String correoElectronico;
  final String contrasena;
  final String telefono;
  final DateTime fechaRegistro;
  final String idUsuario;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correoElectronico,
    required this.contrasena,
    required this.telefono,
    required this.fechaRegistro,
    required this.idUsuario,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: int.parse(json['id']),
      nombre: json['nombre'],
      apellido: json['apellido'],
      correoElectronico: json['correo_electronico'],
      contrasena: json['contrasena'],
      telefono: json['telefono'],
      fechaRegistro: DateTime.parse(json['fecha_registro']),
      idUsuario: json['id_usuario'],
    );
  }
}
