import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';
import 'package:red_peetoze/domain/controller/locations.dart';
import 'package:red_peetoze/domain/use_cases/controllers/conectivity.dart';
import 'package:red_peetoze/domain/use_cases/controllers/permissions.dart';
import 'package:red_peetoze/ui/pages/content/location/widgets/location_card.dart';
import 'package:red_peetoze/ui/pages/content/location/widgets/vista_location.dart';
import 'package:workmanager/workmanager.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  ControllerFirestore controlp = Get.find();
  Controllerauth controluser = Get.find();
  Controllerlocations controlubicacion = Get.find();
  ControllerFirestore controlguardarloc = Get.find();
  ConnectivityController connectivityController = Get.find();
  PermissionsController permissionsController = Get.find();

  @override
  void initState() {
    super.initState();
    Workmanager().registerPeriodicTask(
      "1",
      "ObtenerUbicacionesPeriodicas",
    );
    controlubicacion.obtenerubicacion();
    _initNotificaciones();
  }

  _initNotificaciones() async {
    final _plugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _plugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            background: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 130,
                  child: Obx(
                    () => LocationCard(
                        title: 'MI UBICACIÓN',
                        lat: controlubicacion.locationlat,
                        long: controlubicacion.locationlo,
                        onUpdate: () {
                          if (permissionsController.locationGranted &&
                              connectivityController.connected) {
                            //  _updatePosition(_uid, _name);
                            controlubicacion.obtenerubicacion();
                            var ubicacion = <String, dynamic>{
                              'lat': controlubicacion.locationlat,
                              'lo': controlubicacion.locationlo,
                              'name': controluser.name,
                              'uid': controluser.uid,
                            };
                            controlguardarloc.guardarubicacion(
                                ubicacion, controluser.uid);
                            displayNotification(
                                title: 'Cerca de Mi',
                                body:
                                    '${controlubicacion.cercanos}  Amigos cerca a  mi Ubicaion');
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.blue[50],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => (controlubicacion.locationlat != '')
              ? getInfo(context, controlp.readLocations(), controluser.uid,
                  controlubicacion.locationlat, controlubicacion.locationlo)
              : Center(
                  child: Icon(Icons.accessibility_new),
                ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controlubicacion.obtenerubicacion();
        },
        tooltip: 'Refrescar',
        child: FaIcon(
          FontAwesomeIcons.searchLocation,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  displayNotification({required String title, required String body}) async {
    final _plugin = FlutterLocalNotificationsPlugin();
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _plugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid,
    String lat, String lo) {
  return StreamBuilder(
    stream: ct,
    /*FirebaseFirestore.instance
        .collection('clientes')
        .snapshots(),*/ //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      print(snapshot.connectionState);
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaLocations(
                  locations: snapshot.data!.docs, uid: uid, lat: lat, lo: lo)
              : Text('Sin Datos');
        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}
