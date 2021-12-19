import 'package:flutter/material.dart';
import 'package:red_peetoze/ui/pages/authentication/login/login_screen.dart';
import 'package:red_peetoze/ui/pages/authentication/signup/singup_screen.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AuthenticationPage> {
  Widget? _content;

  // NavBar action
  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 1:
          _content = LoginScreen(
            onViewSwitch: () => _onItemTapped(2),
          );
          break;
        case 2:
          _content = SignUpScreen(
            onViewSwitch: () => _onItemTapped(1),
          );
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _content = LoginScreen(onViewSwitch: () => _onItemTapped(2));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _content,
          ),
        ),
      ),
    );
  }
}
