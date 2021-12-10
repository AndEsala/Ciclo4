import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:red_peetoze/ui/pages/authentication/auth_page.dart';
import 'package:red_peetoze/ui/pages/chat/chat.dart';

/* import 'package:red_egresados/ui/pages/chat/chat_screen.dart';
import 'package:red_egresados/ui/pages/chat/home_chat_screen.dart'; */
import 'package:red_peetoze/ui/pages/content/content_page.dart';
import 'package:red_peetoze/ui/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Red Peetoze',
      // Quitamos el banner DEBUG
      debugShowCheckedModeBanner: false,
      // Establecemos el tema claro
      theme: MyTheme.ligthTheme,
      // Establecemos el tema oscuro
      darkTheme: MyTheme.darkTheme,
      // Por defecto tomara la seleccion del sistema
      themeMode: ThemeMode.system,
      home: const AuthenticationPage(),
      // We add the two possible routes
      routes: {
        '/auth': (context) => const AuthenticationPage(),
        '/content': (context) => const ContentPage(),
        '/chats': (context) => ChatScreen(),
      },
    );
  }
}
