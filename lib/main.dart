import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:red_peetoze/domain/controller/controlchat.dart';

import 'package:red_peetoze/data/controllerrealtime.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';
import 'package:red_peetoze/domain/controller/locations.dart';

import 'package:red_peetoze/domain/use_cases/controllers/permissions.dart';

import 'package:red_peetoze/ui/app.dart';
import 'package:get/get.dart';

import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Workmanager().initialize(
    updatePositionInBackground,
    isInDebugMode: true,
  );
  Get.put(ControllerRealtime());
  Get.put(Controlchat());
  Get.put(ControllerFirestore());
  Get.put(PermissionsController());
  Get.put(Controllerlocations());

  // Get.put(LocationController());

  runApp(const App());
}

void updatePositionInBackground() async {
  Workmanager().executeTask((task, inputData) async {
    Controllerlocations controlubicacion = Get.find();
    controlubicacion.obtenerubicacion();
    return Future.value(true);
  });
}
