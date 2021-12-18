import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:red_peetoze/data/services/location.dart';
import 'package:red_peetoze/domain/controller/control_location.dart';
import 'package:red_peetoze/domain/controller/controlchat.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/data/controllerrealtime.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';
import 'package:red_peetoze/domain/controller/locations.dart';
import 'package:red_peetoze/domain/models/location_model.dart';
import 'package:red_peetoze/domain/use_cases/controllers/location_management.dart';
import 'package:red_peetoze/domain/use_cases/controllers/notification.dart';
import 'package:red_peetoze/domain/use_cases/controllers/permissions.dart';
import 'package:red_peetoze/domain/use_cases/controllers/ui.dart';
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
  // Get.put(Controllerauth());
  Get.put(ControllerRealtime());
  Get.put(Controlchat());
  Get.put(ControllerFirestore());
  Get.put(PermissionsController());
  Get.put(Controllerlocations());
  runApp(const App());
}

void updatePositionInBackground() async {
  final manager = LocationManager();
  final service = LocationService();
  Workmanager().executeTask((task, inputData) async {
    final position = await manager.getCurrentLocation();
    final details = await manager.retrieveUserDetails();
    var location = MyLocation(
        name: details['name']!,
        id: details['uid']!,
        lat: position.latitude,
        long: position.longitude);
    await service.fecthData(
      map: location.toJson,
    );
    log("updated location background"); //simpleTask will be emitted here.
    print("updated location background"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}
