import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ControllerRealtime extends GetxController {
  final databaseReference = FirebaseDatabase.instance.ref();

  void createData(String mensaje, String uid) {
    databaseReference
        .child("mensajes")
        .child('otrosmensajes')
        .push()
        .set({'mensaje': mensaje, 'uid': uid});
  }
}
