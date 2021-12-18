import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:red_peetoze/data/services/location.dart';
import 'package:red_peetoze/domain/controller/control_location.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';
import 'package:red_peetoze/domain/controller/locations.dart';
import 'package:red_peetoze/domain/models/location_model.dart';
import 'package:red_peetoze/domain/use_cases/controllers/location_management.dart';
import 'package:red_peetoze/domain/use_cases/controllers/notification.dart';
import 'package:red_peetoze/domain/use_cases/controllers/permissions.dart';
import 'package:red_peetoze/domain/use_cases/controllers/ui.dart';
import 'package:red_peetoze/ui/pages/content/location/widgets/vista_location.dart';
import 'package:workmanager/workmanager.dart';
import 'widgets/location_card.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  ControllerFirestore controlp = Get.find();
  Controllerauth controluser = Get.find();
  Controllerlocations controlubicacion = Get.find();
  ControllerFirestore controlguardarloc = Get.find();
  final permissionsController = Get.find<PermissionsController>();
  final locationController = Get.find<LocationController>();
  VistaLocations vistaLista = Get.find();
  @override
  void initState() {
    super.initState();
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
    return SingleChildScrollView(
        child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 15.0,
      ),
      child: IntrinsicHeight(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
            Container(
                child: Obx(() => LocationCard(
                          key: const Key("myLocationCard"),
                          title: 'MI UBICACIÓN',
                          lat: controlubicacion.locationlat,
                          long: controlubicacion.locationlo,
                          onUpdate: () {
                            // if (permissionsController.locationGranted) {
                            //&&     connectivityController.connected) {
                            // _updatePosition(_uid, _name);
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
                                title:
                                    'Lat: ${controlubicacion.locationlat} Lon: ${controlubicacion.locationlo}',
                                body: controluser.name);
                          },
                        )
                    // : const CircularProgressIndicator(),
                    )),
            Text(
              'CERCA DE MÍ :',
              style: Theme.of(context).textTheme.headline1,
            ),
            Expanded(
              child: Container(
                  height: 2400.0,
                  child: Obx(
                    () => (controlubicacion.locationlat != '')
                        ? getInfo(
                            context,
                            controlp.readLocations(),
                            controluser.uid,
                            controlubicacion.locationlat,
                            controlubicacion.locationlo)
                        : Center(
                            child: Icon(Icons.accessibility_new),
                          ),
                  )),
            ),
          ])),

      // This trailing comma makes auto-formatting nicer for build methods.
    ));
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
       

// class LocationScreen extends StatefulWidget {
//   // UsersOffers empty constructor
//   LocationScreen({Key? key}) : super(key: key);

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   final authController = Get.find<Controllerauth>();

//   final permissionsController = Get.find<PermissionsController>();

//   // final connectivityController = Get.find<ConnectivityController>();
//   final uiController = Get.find<UIController>();

//   final locationController = Get.find<LocationController>();

//   final notificationController = Get.find<NotificationController>();
//   final ControllerFirestore controlguardarloc = Get.find();
//   ControllerFirestore controlp = Get.find();
//   Controllerlocations controlubicacion = Get.find();

//   final service = LocationService();

//   String distance(double lat1, double lon1, double lat2, double lon2) {
//     double distanceInMeters =
//         Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
//     return distanceInMeters.toString();
//   }

//   @override
//   void initState() {
//     controlubicacion.obtenerubicacion();
//     _initNotificaciones();
//     super.initState();
//   }

//   _initNotificaciones() async {
//     final _plugin = FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     await _plugin.initialize(initializationSettings);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _uid = authController.uid;
//     final _name = authController.name;
//     _init(_uid, _name);
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Obx(
//             () => locationController.location != null
//                 ? LocationCard(
//                     key: const Key("myLocationCard"),
//                     title: 'MI UBICACIÓN',
//                     lat: locationController.location!.lat,
//                     long: locationController.location!.long,
//                     onUpdate: () {
//                       if (permissionsController.locationGranted) {
//                         //&&     connectivityController.connected) {
//                         _updatePosition(_uid, _name);
//                         controlubicacion.obtenerubicacion();
//                         var ubicacion = <String, dynamic>{
//                           'lat': controlubicacion.locationlat,
//                           'lo': controlubicacion.locationlo,
//                           'name': authController.name,
//                           'uid': authController.uid,
//                         };
//                         controlguardarloc.guardarubicacion(
//                             ubicacion, authController.uid);
//                         displayNotification(
//                             title:
//                                 'Lat: ${controlubicacion.locationlat} Lon: ${controlubicacion.locationlo}',
//                             body: authController.name);
//                       }
//                     },
//                   )
//                 : const CircularProgressIndicator(),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Text(
//               'CERCA DE MÍ',
//               style: Theme.of(context).textTheme.headline1,
//             ),
//           ),
//           Text("aqui va el body"),
//           Obx(() => getInfo(
//               context,
//               controlp.readLocations(),
//               authController.uid,
//               controlubicacion.locationlat,
//               controlubicacion.locationlo)),
//         ],
//       ),
//     );
//   }

//   _init(String uid, String name) {
//     if (!permissionsController.locationGranted) {
//       permissionsController.manager.requestGpsPermission().then((granted) {
//         if (granted) {
//           locationController.locationManager = LocationManager();
//           _updatePosition(uid, name);
//         } else {
//           uiController.screenIndex = 0;
//         }
//       });
//     } else {
//       locationController.locationManager = LocationManager();
//       _updatePosition(uid, name);
//     }
//     notificationController.createChannel(
//         id: 'users-location',
//         name: 'Users Location',
//         description: 'Other users location...');
//   }

//   _updatePosition(String uid, String name) async {
//     final position = await locationController.manager.getCurrentLocation();
//     await locationController.manager.storeUserDetails(uid: uid, name: name);
//     locationController.location = MyLocation(
//         name: name, id: uid, lat: position.latitude, long: position.longitude);
//     Workmanager().registerPeriodicTask(
//       "1",
//       "Localizacion periodica",
//     );
//   }

//   displayNotification({required String title, required String body}) async {
//     final _plugin = FlutterLocalNotificationsPlugin();
//     print("doing test");
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'your channel id', 'your channel name',
//         importance: Importance.max, priority: Priority.high);
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await _plugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'It could be anything you pass',
//     );
//   }

//   @override
//   Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid,
//       String lat, String lo) {
//     return StreamBuilder(
//       stream: ct,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         print("esta es la conexion : ${snapshot.connectionState}");
//         switch (snapshot.connectionState) {

//           //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
//           case ConnectionState.waiting:
//             return Center(child: CircularProgressIndicator());

//           case ConnectionState.active:
//             if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//             // print(snapshot.data);
//             return snapshot.data != null
//                 ? VistaLocations(
//                     locations: snapshot.data!.docs, uid: uid, lat: lat, lo: lo)
//                 : Text('Sin Datos');

//           default:
//             return Text('Presiona el boton para recargar');
//         }
//       },
//     );
//   }
// }
