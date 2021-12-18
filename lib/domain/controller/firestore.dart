import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ControllerFirestore extends GetxController {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readItems() {
    CollectionReference listado = _db.collection('post');

    return listado.snapshots();
  }

  Stream<QuerySnapshot> readLocations() {
    CollectionReference listado = _db.collection('ubicacion');

    return listado.snapshots();
  }

  Future<void> crearestado(Map<String, dynamic> post, foto) async {
    var url = '';
    if (foto != null) url = await cargarfoto(foto, DateTime.now().toString());
    print(url);
    post['fotopost'] = url.toString();

    await _db.collection('post').doc().set(post).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> actualizarestado(String id, Map<String, dynamic> post) async {
    await _db.collection('post').doc(id).update(post).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> eliminarestados(String id) async {
    await _db.collection('post').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> guardarubicacion(Map<String, dynamic> ubicacion, uid) async {
    await _db.collection('ubicacion').doc(uid).set(ubicacion).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<dynamic> cargarfoto(var foto, var idfoto) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("post");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idfoto).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }
}
