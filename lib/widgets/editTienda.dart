// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tienda_god/services/Urls.dart';

import 'package:tienda_god/services/tienda_service.dart';

import 'package:tienda_god/widgets/inputsDeco.dart';

class editTienda extends StatefulWidget {
final String idTienda;
  const editTienda({super.key,  required this.idTienda});

  @override
  State<editTienda> createState() => _editTiendaState();
}

class _editTiendaState extends State<editTienda> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario

  late TextEditingController nombreTienda = TextEditingController();

 
  late TextEditingController telefono = TextEditingController();


  @override
  Widget build(BuildContext context) {

String idTienda=widget.idTienda;
    return SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
            future: recuperarTiendaId(idTienda),
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
                final tienda = snapshot.data ?? {};

                nombreTienda.text = tienda['nombre_tienda'] ?? '';
          
                telefono.text = tienda['telefono'] ?? '';
         String idUsuarioT=tienda['id_usuarioT'];
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
                             Text('Editar Tienda',  style: Theme.of(context).textTheme.headline6,),
                               const SizedBox(
                              height: 10,
                            ),
                            Image.network(imagenes + tienda['logo_url']),
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
                                      enabled: false,
                                      controller: nombreTienda,
                                      decoration:
                                          InputDecorations.inputDecoration(
                                        hintText: 'INGRESE SU NOMBRE',
                                        labelText: 'Nombre Tienda',
                                        icono: Icon(Icons.business_center),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                   
                             
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: telefono,
                                      decoration:
                                          InputDecorations.inputDecoration4(
                                        hintText: '1-100',
                                        labelText: 'Cantidad que su Producto',
                                        icono: Icon(Icons.phone),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),    
                                    
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                     editarTienda(idUsuarioT, telefono.text);
                        await Navigator.pushNamed(context, '/tienda',arguments: idTienda);
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
