import 'package:flutter/material.dart';
import 'package:tienda_god/services/tienda_service.dart';
import 'package:tienda_god/widgets/inputsDeco.dart';


SingleChildScrollView recuperarformTienda(BuildContext context) {
  final TextEditingController _nombreTiendaController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final idUsuarioT = ModalRoute.of(context)?.settings.arguments as String;
  return SingleChildScrollView(
      child: Column(children: [
    const SizedBox(
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
            'Recupera tu Tienda',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
            TextFormField(
              controller: _nombreTiendaController,
              decoration: InputDecorations.inputDecoration(icono: const Icon(Icons.person),hintText: 'Ingrese Nombre',labelText: 'Ingrese Nombre de la Tienda'),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecorations.inputDecoration(labelText: 'Teléfono',hintText: 'Ingrese Telefono',icono: Icon(Icons.phone)),
            ),
            ElevatedButton(
              onPressed: () async {
                // Aquí puedes realizar la lógica para enviar los datos al servidor
                final nombreTienda = _nombreTiendaController.text;
                final telefono = _telefonoController.text;

                var a =
                    await recuperarTienda(nombreTienda, telefono, idUsuarioT);
                print(a);
                Navigator.pushNamed(context, '/tienda/cambiar-contraseña',
                    arguments: a);
              },
              child: Text('Recuperar Tienda'),
            ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ]));
}
