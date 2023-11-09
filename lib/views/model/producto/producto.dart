class Producto {
  final int id;
  final String idProducto;
  final String nombreProducto;
  final String descripcion;
  final double precio;
  final int cantidad;
  final String tipoProducto;
  final String imagenUrl;
  final int idTienda;
  final DateTime fechaProducto;

  Producto({
    required this.id,
    required this.idProducto,
    required this.nombreProducto,
    required this.descripcion,
    required this.precio,
    required this.cantidad,
    required this.tipoProducto,
    required this.imagenUrl,
    required this.idTienda,
    required this.fechaProducto,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      idProducto: json['id_producto'],
      nombreProducto: json['nombre_producto'],
      descripcion: json['descripcion'],
      precio: double.parse(json['precio']),
      cantidad: int.parse(json['cantidad']),
      tipoProducto: json['tipo_producto'],
      imagenUrl: json['imagen_url'],
      idTienda: json['id_tienda'],
      fechaProducto: DateTime.parse(json['fecha_producto']),
    );
  }
}
