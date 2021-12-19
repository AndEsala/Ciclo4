import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:red_peetoze/domain/controller/locations.dart';
import 'package:red_peetoze/ui/pages/content/location/widgets/location_card.dart';
import 'package:url_launcher/url_launcher.dart';

class VistaLocations extends StatelessWidget {
  final List locations;
  final String uid;
  final String lat;
  final String lo;
  const VistaLocations(
      {required this.locations,
      required this.uid,
      required this.lat,
      required this.lo});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listacalculo = [];
    Controllerlocations controlubicacion = Get.find();

//*********Calculo de Distancias***********//

    String distance(
        double lat1, double lon1, double lat2, double lon2, String unit) {
      double distanceInMeters =
          Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
      return (distanceInMeters / 1000).toString();
    }

    for (int i = 0; i < locations.length; i++) {
      if (uid != locations[i]['uid']) {
        String distancia = distance(
            double.parse(lat),
            double.parse(lo),
            double.parse(locations[i]['lat']),
            double.parse(locations[i]['lo']),
            'Km');

        var calc = <String, dynamic>{
          'name': locations[i]['name'],
          'lat': locations[i]['lat'],
          'lo': locations[i]['lo'],
          'Dist': distancia
        };
        listacalculo.add(calc);
      }
    }
    controlubicacion.cercanos = listacalculo.length.toString();

    return ListView.builder(
      itemCount: listacalculo.length == 0 ? 0 : listacalculo.length,
      itemBuilder: (context, posicion) {
        //print(listacalculo[posicion].id);
        double dis = double.parse(listacalculo[posicion]['Dist']);

        return LocationCard(
          title: listacalculo[posicion]['name'],
          lat: listacalculo[posicion]['lat'],
          long: listacalculo[posicion]['lo'],
          distance: dis,
        );
      },
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
    ); // });
  }
}
