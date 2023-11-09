  import 'package:flutter/material.dart';

SafeArea iconopersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
SafeArea iconoproducto() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

SafeArea iconotienda() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.store_mall_directory,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

Container cajapupura(Size size, Color color1, Color color2) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color1, color2],
      ),
    ),
    width: double.infinity,
    height: size.height * 0.2,
  );
}
