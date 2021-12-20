import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/use_cases/controllers/conectivity.dart';
import 'package:red_peetoze/ui/pages/content/content_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const LoginScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  TextEditingController usuario = TextEditingController();
  TextEditingController passwd = TextEditingController();
  late ConnectivityController connectivityController;

  Controllerauth controluser = Get.find();

  @override
  void initState() {
    autoLogIn();
    connectivityController = Get.find<ConnectivityController>();
    super.initState();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? passw = prefs.getString('pass');

    if (email != null) {
      setState(() {
        usuario.text = email;
        passwd.text = passw!;
        if (controluser.userf != 'Ingrese sus datos')
          _inicio(usuario.text, passwd.text);
      });
      return;
    }
  }

  _inicio(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await controluser.ingresarEmail(theEmail, thePassword);
      if (controluser.userf != 'Ingrese sus datos' || controluser.userf == '') {
        Future.delayed(Duration(seconds: 2));
        Get.offNamed('/content');
      } else {
        Future.delayed(Duration(seconds: 2));
        Get.snackbar('Error', 'Los campos no pueden estar vacios',
            icon: Icon(Icons.error, color: Colors.red),
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (err) {
      print(err.toString());
      Get.snackbar('Fallo', 'revise sus datos',
          icon: Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  _google() async {
    try {
      await controluser.ingresarGoogle();
      if (controluser.userf != 'Ingrese sus datos' ||
          controluser.userf != null) {
        Future.delayed(Duration(seconds: 2));
        Get.to(() => ContentPage());
      }
    } catch (err) {
      print(err.toString());
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
            ),
            Center(
                child: Image.asset(
              'assets/images/login.png',
              scale: 2.5,
              fit: BoxFit.scaleDown,
            )),
            // const

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Iniciar sesión",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // key: const Key("signInEmail"),

                controller: usuario,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Correo electrónico',
                ),
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // key: const Key("signInPassword"),
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
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ))),
                      icon: Icon(Icons.email),
                      label: const Text(
                        "Iniciar Sesion",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (connectivityController.connected) {
                          await _inicio(usuario.text, passwd.text);
                        } else {
                          Get.showSnackbar(
                            GetSnackBar(
                              message: "No estas conectado a la red.",
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            Obx(() => Text(controluser.userf)),

            ElevatedButton.icon(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ))),
              onPressed: () async {
                if (connectivityController.connected) {
                  await _google();
                } else {
                  Get.showSnackbar(
                    GetSnackBar(
                      message: "No estas conectado a la red.",
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
              label: const Text(
                "Iniciar con Google",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 110,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No tienes Cuenta?"),
                TextButton(
                  // key: const Key("toSignUpButton"),
                  child: const Text(
                    " Crear Cuenta",
                  ),
                  onPressed: widget.onViewSwitch,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usuario.dispose();
    passwd.dispose();
    super.dispose();
  }
}
