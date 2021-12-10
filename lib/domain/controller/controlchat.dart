import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:red_peetoze/domain/models/message_model.dart';

class Controlchat extends GetxController {
  final DatabaseReference _mensajesRef =
      FirebaseDatabase.instance.ref().child('mensajes');

  void guardarMensaje(Message mensaje) {
    _mensajesRef.push().set(mensaje.toJson());
  }

  void actualizarMensaje(Map<String, dynamic> datosmod, String idmensaje) {
    _mensajesRef.child(idmensaje).update(datosmod);
  }

  void deleteMensaje(String idmensaje) {
    _mensajesRef.child(idmensaje).remove();
  }

  Query getMensajes() => _mensajesRef;
}
