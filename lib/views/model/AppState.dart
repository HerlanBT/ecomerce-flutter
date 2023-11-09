import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String? aux;

  void updateAux(String newValue) {
    aux = newValue;
    notifyListeners(); // Notifica a los widgets que escuchan los cambios
  }
}
