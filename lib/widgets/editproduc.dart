// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';
import 'package:tienda_god/services/producto_service.dart';

import 'package:tienda_god/widgets/inputsDeco.dart';

class editproduct extends StatefulWidget {
  final String idProductos;
  final String idTienda;
  const editproduct({super.key, required this.idProductos, required this.idTienda});

  @override
  State<editproduct> createState() => _editproductState();
}

class _editproductState extends State<editproduct> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario

  late TextEditingController nombreProducto = TextEditingController();
  late TextEditingController descripcion = TextEditingController();
  late TextEditingController preciocontroller = TextEditingController();
  late TextEditingController cantidadcontroller = TextEditingController();
  late TextEditingController tipoProducto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String idProducto = widget.idProductos;

    return SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
            future: recuperarProductoPorID(idProducto),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final producto = snapshot.data ?? {};

                nombreProducto.text = producto['nombre_producto'] ?? '';
                descripcion.text = producto['descripcion'] ?? '';
                preciocontroller.text = producto['precio'] ?? '';
                cantidadcontroller.text = producto['cantidad'] ?? '';
                tipoProducto.text = producto['tipo_producto'] ?? '';
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 140,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                             Text('Editar Producto',  style: Theme.of(context).textTheme.headline6,),
                               const SizedBox(
                              height: 10,
                            ),
                            Image.network(imagenes + producto['imagen_url']),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: nombreProducto,
                                      decoration:
                                          InputDecorations.inputDecoration(
                                        hintText: 'INGRESE SU NOMBRE',
                                        labelText: 'Nombre',
                                        icono: Icon(Icons.business_center),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      controller:
                                          descripcion, // Asigna el controlador aquí
                                      decoration: InputDecoration(
                                        labelText: 'Escribe tu texto aquí',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: cantidadcontroller,
                                      decoration:
                                          InputDecorations.inputDecoration(
                                        hintText: '1-100',
                                        labelText: 'Cantidad que su Producto',
                                        icono: Icon(Icons.add_circle_outlined),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: preciocontroller,
                                      decoration:
                                          InputDecorations.inputDecoration(
                                        hintText: '00.00',
                                        labelText: 'Precio del Producto',
                                        icono: Icon(Icons.monetization_on),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        width: 900,
                                        child: DropdownButtonFormField<String>(
                                          items: tipos_productos
                                              .map((String tipos) {
                                            return DropdownMenuItem<String>(
                                              child: Text(tipos),
                                              value: tipos,
                                            );
                                          }).toList(),
                                          value: tipoProducto
                                              .text, // Establece el valor seleccionado
                                          onChanged:
                                              null, // Deshabilita la opción de cambiar la selección
                                          decoration:
                                              InputDecorations.inputDecoration(
                                            hintText: 'Tipo de Producto',
                                            labelText: 'Tipo de Producto',
                                            icono: const Icon(
                                                Icons.content_paste_sharp),
                                          ),
                                          style: TextStyle(color: Colors.black),
                                          dropdownColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        double precio =
                                            double.parse(preciocontroller.text);
                                        int cantidad =
                                            int.parse(cantidadcontroller.text);
                                        editarProducto(
                                            nombreProducto.text,
                                            descripcion.text,
                                            precio,
                                            cantidad,
                                            idProducto);
                                                await  Navigator.of(context).pushReplacementNamed('/tienda',arguments: widget.idTienda);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors
                                            .blue, // Color del texto dentro del botón
                                        padding: const EdgeInsets.all(
                                            16), // Espaciado interno
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Borde redondeado
                                        ),
                                      ),
                                      child: const Text(
                                        'Enviar',
                                        style: TextStyle(
                                          fontSize:
                                              18, // Tamaño de fuente del texto
                                          fontWeight: FontWeight
                                              .bold, // Peso de la fuente (negrita)
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
