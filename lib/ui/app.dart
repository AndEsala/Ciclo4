import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_peetoze/domain/controller/control_location.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/use_cases/controllers/conectivity.dart';
import 'package:red_peetoze/domain/use_cases/controllers/notification.dart';
import 'package:red_peetoze/domain/use_cases/controllers/permissions.dart';
import 'package:red_peetoze/domain/use_cases/controllers/ui.dart';
import 'package:red_peetoze/domain/use_cases/permission_management.dart';
import 'package:red_peetoze/domain/use_cases/theme_management.dart';
import 'package:red_peetoze/ui/pages/authentication/auth_page.dart';
import 'package:red_peetoze/ui/pages/chat/chat.dart';
import 'package:red_peetoze/ui/pages/content/content_page.dart';
import 'package:red_peetoze/ui/pages/content/location/widgets/vista_location.dart';
import 'package:red_peetoze/ui/theme/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // The future is part of the state of our widget. We should not call `initializeApp`
  // directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _stateManagementInit();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Center(
              child: Text("Hubo un error con firebase"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          // _firebaseStateInit();
          return GetMaterialApp(
            title: 'Red Egresados MinTIC',
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

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(
          home: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void _stateManagementInit() {
    // Dependency Injection
    UIController uiController = Get.put(UIController());
    uiController.themeManager = ThemeManager();

    // Reactive
    ever(uiController.reactiveBrightness, (bool isDarkMode) {
      uiController.manager.changeTheme(isDarkMode: isDarkMode);
    });

    PermissionsController permissionsController =
        Get.put(PermissionsController());
    permissionsController.permissionManager = PermissionManager();

    // Auth Controller
    Controllerauth authController = Get.put(Controllerauth());

    // State management: listening for changes on using the reactive var
    ever(authController.reactiveAuth, (bool authenticated) {
      // Using Get.off so we can't go back when auth changes
      // This navigation triggers automatically when auth state changes on the app state
      if (authenticated) {
        Get.offNamed('/content');
      } else {
        Get.offNamed('/auth');
      }
    });
    // Connectivity Controller
    ConnectivityController connectivityController =
        Get.put(ConnectivityController());
    // Connectivity stream
    Connectivity().onConnectivityChanged.listen((connectivityStatus) {
      log("connection changed");
      connectivityController.connectivity = connectivityStatus;
    });

    // Notification controller
    NotificationController notificationController =
        Get.put(NotificationController());
    notificationController.initialize();
  }

  // _firebaseStateInit() {
  //   Controllerauth authController = Get.find<Controllerauth>();
  //   // Setting manager
  //   authController.authManagement = AuthManagement(
  //     auth: PasswordAuth(),
  //   );
  //   // Watching auth state changes
  //   AuthInterface.authStream.listen(
  //     (user) => authController.currentUser = user,
  //   );
  // }
}
