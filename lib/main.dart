import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:red_peetoze/domain/controller/controlchat.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/data/controllerrealtime.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';
import 'package:red_peetoze/ui/app.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(Controllerauth());
  Get.put(ControllerRealtime());
  Get.put(Controlchat());
  Get.put(ControllerFirestore());
  runApp(const App());
}
