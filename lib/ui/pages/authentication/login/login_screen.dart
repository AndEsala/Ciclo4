import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:get/get.dart';
import 'package:red_egresados/domain/controller/controllerauth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const LoginScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  TextEditingController usuario = TextEditingController();
  TextEditingController passwd = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  Controllerauth controluser = Get.find();

  bool _validate = false;

  _login(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await controluser.registrarEmail(theEmail, thePassword);
      if (controluser.userf != 'Sin registro') {
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

  _inicio(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await controluser.ingresarEmail(theEmail, thePassword);
      if (controluser.userf != 'Ingrese sus datos') {
        Future.delayed(Duration(seconds: 2));
        Get.offNamed('/content');
      }
    } catch (err) {
      print(err.toString());
      Get.snackbar('Fallo', 'revise sus datos',
          icon: Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM);
    }

    //   Get.snackbar(
    //     "Login",
    //     err.toString(),
    //     icon: Icon(Icons.person, color: Colors.red),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
  }

  _google() async {
    try {
      await controluser.ingresarGoogle();
      Get.offNamed('/content');
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
    return Scaffold(
        body: GetBuilder<Controllerauth>(
      init: Controllerauth(),
      builder: (_) {
        return Form(
          key: _formkey,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Iniciar sesión",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: usuario,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwd,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contraseña'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SignInButton(
                            Buttons.Email,
                            text: "Iniciar Sesion",
                            shape: StadiumBorder(
                                side: BorderSide(style: BorderStyle.solid)),
                            onPressed: () async {
                              _inicio(usuario.text, passwd.text);
                            },
                            padding: EdgeInsets.only(right: 4),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => Text(controluser.userf)),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: widget.onViewSwitch,
                      child: const Text("Registrarse"),
                    ),
                    const Spacer(),
                  ])),
        );
      },
    ));
  }

//   @override
//   void dispose() {
//     email.dispose();
//     password.dispose();
//     super.dispose();
//   }
}
