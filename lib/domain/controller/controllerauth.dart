import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Controllerauth extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<dynamic> _usuarior = "Ingrese sus datos".obs;
  late Rx<dynamic> _uid = "".obs;
  late Rx<dynamic> _name = "Anonimo".obs;
  late Rx<dynamic> _photo = "".obs;

  String get userf => _usuarior.value;
  String get photorul => _photo.value;
  String get uid => _uid.value;
  String get name => _name.value;

  Future<void> registrarEmail(dynamic _email, dynamic _passw) async {
    try {
      UserCredential usuario = await auth.createUserWithEmailAndPassword(
          email: _email, password: _passw);

      _usuarior.value = usuario.user!.email;
      _name.value = usuario.user!.email;
      _photo.value =
          'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png';
      _uid.value = usuario.user!.uid;

      Get.snackbar('Bienvenido', 'Registro exitoso',
          icon: Icon(Icons.person, color: Colors.blue),
          snackPosition: SnackPosition.TOP);

      print(usuario);

      return Future.value(true);
      // return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('Correo ya Existe');

        return Future.error('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> ingresarEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      _usuarior.value = usuario.user!.email;

      _uid.value = usuario.user!.uid;
      _name.value = usuario.user!.email;
      _photo.value =
          'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png';

      Get.snackbar('Bienvenido', 'Ingreso exitoso',
          icon: Icon(Icons.person, color: Colors.blue),
          snackPosition: SnackPosition.TOP);
      //    _photo.value = usuario.user!.photoURL;
      print(usuario);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Correo no encontrado');
        return Future.error('user-not-found');
      } else if (e.code == 'wrong-password') {
        print('Password incorrecto');
        return Future.error('wrong-password');
      }
    }
  }

  Future<void> ingresarGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// Obtain the auth details from the request

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential usuario =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _usuarior.value = usuario.user!.email;
      _uid.value = usuario.user!.uid;
      _name.value = usuario.user!.displayName;
      _photo.value = usuario.user!.photoURL;
      Get.snackbar('Bienvenido', 'Ingreso con su cuenta de Google',
          icon: Icon(Icons.person, color: Colors.blue),
          snackPosition: SnackPosition.TOP);

      return Future.value(true);
    } catch (e) {
      return Future.error('Error');
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar('Exito', 'Finalizo sesion',
          icon: Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.TOP);
      _usuarior.value = "Ingrese sus datos";
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
