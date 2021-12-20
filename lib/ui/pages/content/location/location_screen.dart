import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:red_peetoze/data/services/location.dart';
import 'package:red_peetoze/domain/controller/control_location.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';
import 'package:red_peetoze/domain/controller/locations.dart';
import 'package:red_peetoze/domain/models/location_model.dart';
import 'package:red_peetoze/domain/use_cases/controllers/conectivity.dart';
import 'package:red_peetoze/domain/use_cases/controllers/location_management.dart';
import 'package:red_peetoze/domain/use_cases/controllers/notification.dart';
import 'package:red_peetoze/domain/use_cases/controllers/permissions.dart';
import 'package:red_peetoze/ui/pages/content/location/widgets/location_card.dart';
import 'package:red_peetoze/ui/pages/content/location/widgets/vista_location.dart';
import 'package:workmanager/workmanager.dart';

class LocationScreen extends StatelessWidget {
  // UsersOffers empty constructor
  LocationScreen({Key? key}) : super(key: key);
}
// ignore: non_constant_identifier_names
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
    final _uid = authController.uid;
    final _name = authController.name;
    _init(_uid, _name);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => locationController.location != null
                ? LocationCard(
                    key: const Key("myLocationCard"),
                    title: 'MI UBICACIÓN',
                    lat: locationController.location!.lat,
                    long: locationController.location!.long,
                    onUpdate: () {
                      if (permissionsController.locationGranted) {
                        //&&     connectivityController.connected) {
                        _updatePosition(_uid, _name);
                      }
                    },
                  )
                : const CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline1,
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

                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else {
              return const CircularProgressIndicator();
            }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
          })
        ],
      ),
    );
  }

  _init(String uid, String name) {
    if (!permissionsController.locationGranted) {
      permissionsController.manager.requestGpsPermission().then((granted) {
        if (granted) {
          locationController.locationManager = LocationManager();
          _updatePosition(uid, name);
        } else {
          uiController.screenIndex = 0;
        }
      });
    } else {
      locationController.locationManager = LocationManager();
      _updatePosition(uid, name);
    }
    notificationController.createChannel(
        id: 'users-location',
        name: 'Users Location',
        description: 'Other users location...');
  }

  _updatePosition(String uid, String name) async {
    final position = await locationController.manager.getCurrentLocation();
    await locationController.manager.storeUserDetails(uid: uid, name: name);
    locationController.location = MyLocation(
        name: name, id: uid, lat: position.latitude, long: position.longitude);
    Workmanager().registerPeriodicTask(
      "1",
      "locationPeriodicTask",
    );
  }
}
