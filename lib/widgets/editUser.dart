// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:tienda_god/services/usuario_service.dart';
import 'package:tienda_god/widgets/inputsDeco.dart';

class editUser extends StatefulWidget {
  final String idUser;
  const editUser({super.key, required this.idUser});

  @override
  State<editUser> createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario

  late TextEditingController nombre = TextEditingController();
  late TextEditingController apellido = TextEditingController();
  late TextEditingController correo = TextEditingController();

  late TextEditingController telefono = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String iduser = widget.idUser;
    return SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
            future: obtenerUsuario(iduser),
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
                final usuario = snapshot.data ?? {};

                nombre.text = usuario['nombre'] ?? '';
                apellido.text = usuario['apellido'] ?? '';
                correo.text = usuario['correo_electronico'] ?? '';
                telefono.text = usuario['telefono'] ?? '';
                String idUsuario = iduser;
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
                            Text(
                              'Editar Usuario',
                              style: Theme.of(context).textTheme.headline6,
                            ),
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
                                      controller: nombre,
                                      decoration:
                                          InputDecorations.inputDecoration(
                                        labelText: 'Nombre',
                                        icono: Icon(Icons.person),
                                        hintText: 'Nombre',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: apellido,
                                      decoration:
                                          InputDecorations.inputDecoration(
                                        labelText: 'Apellido',
                                        icono: Icon(Icons.person),
                                        hintText: 'Apellido',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: correo,
                                      enabled: false,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration:
                                          InputDecorations.inputDecoration(
                                        labelText: 'Correo Electrónico',
                                        icono: Icon(Icons.email),
                                        hintText: 'Ingrese Correo',
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
                                        await editarUsuario(
                                          idUsuario,
                                          nombre: nombre.text,
                                          apellido: apellido.text,
                                          correo: correo.text,
                                          telefono: telefono.text,
                                        );
                                        await Navigator.popAndPushNamed(
                                            context, '/user',
                                            arguments: idUsuario);
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
