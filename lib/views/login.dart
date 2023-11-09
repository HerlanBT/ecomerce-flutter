import 'package:flutter/material.dart';
import 'package:tienda_god/widgets/NavigatorButton.dart';
import 'package:tienda_god/widgets/drawer.dart';
import 'package:tienda_god/widgets/formlogin.dart';
import 'package:tienda_god/widgets/widgetsForm.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final color1 = Color.fromARGB(255, 134, 4, 54);
    final color2 = Color.fromARGB(255, 77, 5, 105);
    return Scaffold(
         drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapupura(Size.infinite, color1, color2),
            iconopersona(),
            loginform(context),
          ],
        ),
      ),
      bottomNavigationBar: Nav(
        currentPage: 2,
      ),
    );
  }
}
