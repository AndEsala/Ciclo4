import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:red_egresados/domain/controller/controllerauth.dart';
import 'package:red_egresados/ui/pages/content/location/location_screen.dart';
import 'package:red_egresados/ui/pages/content/post/postScreen.dart';
import 'package:red_egresados/ui/pages/content/public_post/public_offers_screen.dart';
import 'package:red_egresados/ui/pages/content/Activity/activ_screen.dart';
import 'package:red_egresados/ui/pages/content/statesP/state_screen.dart';

import 'package:get/get.dart';
import 'package:red_egresados/ui/widgets/appbar.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ContentPage> {
  int _selectedIndex = 0;
  Widget _content = const ActivScreen();
  Controllerauth controluser = Get.find();

  // NavBar action
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          _content = const ActivScreen();
          break;
        case 1:
          _content = const StatesScreen();
          break;
        case 2:
          _content = const PublicScreen();
          break;
        case 3:
          _content = const PostScreen();
          break;
        case 4:
          _content = const LocationScreen();
          break;
        default:
          _content = const ActivScreen();
      }
    });
  }

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
          tile: const Text("Peetoze"),
          iconPets: Icon(Icons.pets),
          context: context,
          onSignOff: () {
            controluser.logOut();
            Get.offNamed('/auth');
          }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _content,
          ),
        ),
      ),
      // Content screen navbar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Actividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline_rounded),
            label: 'Estados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public_outlined),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_comment_rounded),
            label: 'ADD Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined),
            label: 'Ubicación',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
