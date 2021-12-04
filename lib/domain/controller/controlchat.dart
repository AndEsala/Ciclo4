import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:red_egresados/domain/models/message_model.dart';

class Controlchat extends GetxController {
  final DatabaseReference _mensajesRef =
      FirebaseDatabase.instance.reference().child('mensajes');

  void guardarMensaje(Message mensaje) {
    _mensajesRef.push().set(mensaje.toJson());
  }

  Query getMensajes() => _mensajesRef;
}
