import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:get/get.dart';
import 'package:red_peetoze/domain/use_cases/controllers/conectivity.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const SignUpScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SignUpScreen> {
  // final nameController = TextEditingController();
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController passwd = TextEditingController();
  Controllerauth controluser = Get.find();
  final connectivityController = Get.find<ConnectivityController>();

  _register(theEmail, thePassword) async {
    print('_register $theEmail $thePassword');
    try {
      await controluser.registrarEmail(theEmail, thePassword);
      if (controluser.userf != 'Ingrese sus datos') {
        Get.offNamed('/content');
      }
    } catch (err) {
      print(err.toString());
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.logout, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Crear Cuenta",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: nameController,
          //     decoration: const InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: 'Usuario',
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: usuario,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwd,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ))),
                    onPressed: () {
                      if (connectivityController.connected) {
                        if (usuario.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "El campo de Correo no puede estar vacio.!",
                            icon: Icon(Icons.error, color: Colors.red),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (passwd.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "El campo de la Clave no puede estar vacio.!",
                            icon: Icon(Icons.error, color: Colors.red),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (_validateEmail(usuario.text) == true) {
                          _register(usuario.text, passwd.text);
                        } else {
                          Get.snackbar(
                            "Error",
                            "Ingrese un Correo valido",
                            icon: Icon(Icons.error, color: Colors.red),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      } else {
                        Get.showSnackbar(
                          GetSnackBar(
                            message: "No estas conectado a la red.",
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Crear Cuenta",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Ya tienes cuenta ?"),
              TextButton(
                onPressed: widget.onViewSwitch,
                child: const Text("Iniciar Sesion"),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // nameController.dispose();
    usuario.dispose();
    passwd.dispose();
    super.dispose();
  }

  bool _validateEmail(String value) {
    RegExp regex = new RegExp(
        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");

    return (!regex.hasMatch(value)) ? false : true;
  }
}
