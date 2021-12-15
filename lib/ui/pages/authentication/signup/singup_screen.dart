import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:get/get.dart';

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
              "Creación de usuario",
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
                labelText: 'Clave',
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
                    onPressed: () {
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

                      // {Get.offNamed('/content');}
                    },
                    child: const Text("Registrar"),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: widget.onViewSwitch,
            child: const Text("Entrar"),
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
