import 'package:flutter/material.dart';
import 'package:tienda_god/services/usuario_service.dart';

SingleChildScrollView recuperaruserform(BuildContext context) {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegExp = RegExp(r'^\d{10}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  return SingleChildScrollView(
    child: Column(
      children: [
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
                'Recuperar Usuario',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      TextFormField(
                        controller: _apellidoController,
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      TextFormField(
                        controller: _correoController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu correo electrónico';
                          } else if (!isValidEmail(value)) {
                            return 'Ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _telefonoController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu teléfono';
                          } else if (!isValidPhoneNumber(value)) {
                            return 'Ingresa un número de teléfono válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Aquí puedes enviar la solicitud para recuperar al usuario al servidor
                          final correo = _correoController.text;
                          final nombre = _nombreController.text;
                          final apellido = _apellidoController.text;
                          final telefono = _telefonoController.text;
                          String idUsuario = await recuperarUsuario(
                              correo, nombre, apellido, telefono);

                          Navigator.pushReplacementNamed(
                              context, '/user/cambiar-contreseña',
                              arguments: idUsuario);
                        },
                        child: Text('Recuperar Usuario'),
                      ),
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
