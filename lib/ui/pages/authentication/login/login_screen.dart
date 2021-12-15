import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
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

  Controllerauth controluser = Get.find();

  @override
  void initState() {
    autoLogIn();
    // connectivityController = Get.find<ConnectivityController>();
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
    return Scaffold(
        body: GetBuilder<Controllerauth>(
          init: Controllerauth(),
          builder: (_) {
            return Form(
              // key: _formkey,
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
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 30.0),
                                  child: SignInButton(
                                    Buttons.Email,
                                    text: "Iniciar con Email",
                                    shape: const StadiumBorder(),
                                    mini: false,
                                    onPressed: () async {
                                      _inicio(usuario.text, passwd.text);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 30.0),
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _google();
          },
          child: FaIcon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
        ));
  }

  @override
  void dispose() {
    usuario.dispose();
    passwd.dispose();
    super.dispose();
  }
}
