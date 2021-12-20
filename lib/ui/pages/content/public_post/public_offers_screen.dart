import 'package:flutter/material.dart';
import 'package:red_peetoze/domain/models/animals.dart';
import 'widgets/offer_card.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PublicScreen extends StatefulWidget {
  // PublicOffersScreen empty constructor
  const PublicScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PublicScreen> {
  // ignore: unused_field
  late Future<List<Animal>> _animales;

  /* final items = List<String>.generate(2, (i) => "Item $i"); */

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _animales,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(children: listAnimals(snapshot.data));
        } else if (snapshot.hasError) {
          print(snapshot.error);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animales = listAnimales();
  }

  Future<List<Animal>> listAnimales() async {
    final url = Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=g1NrAfZ541uFVBy9YHv2twOYgfHaulpj&q=dogs&limit=10&offset=0&rating=g&lang=es');
    final res = await http.get(url);

    List<Animal> animals = [];

    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      final jsonData = jsonDecode(body);

      for (var item in jsonData['data']) {
        animals.add(Animal(
            img: item['images']['downsized']['url'], titulo: item['title']));
      }

      return animals;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  List<Widget> listAnimals(data) {
    List<Widget> listAni = [];

    for (var anil in data) {
      OfferCard cardAnimal = OfferCard(
        title: anil.titulo,
        content: anil.img,
        pet: "Mascota",
        payment: 250000,
      );

      listAni.add(cardAnimal);
    }

    return listAni;
  }
}
