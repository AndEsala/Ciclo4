import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:red_egresados/domain/controller/controllerauth.dart';
import 'package:red_egresados/ui/app.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(Controllerauth());
  runApp(const App());
}
