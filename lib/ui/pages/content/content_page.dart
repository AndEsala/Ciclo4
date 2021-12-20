import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/use_cases/controllers/ui.dart';
import 'package:red_peetoze/ui/pages/content/location/location_screen.dart';

import 'package:red_peetoze/ui/pages/content/post/post_screen.dart';
import 'package:red_peetoze/ui/pages/content/public_post/public_offers_screen.dart';
import 'package:red_peetoze/ui/pages/content/Activity/activ_screen.dart';
import 'package:red_peetoze/ui/pages/content/statesP/state_screen.dart';

import 'package:get/get.dart';
import 'package:red_peetoze/ui/widgets/appbar.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  Widget _getScreen(int index) {
    // _selectedIndex = index;
    switch (index) {
      case 0:
        return const ActivScreen();
      // break;
      case 1:
        return const StatesScreen();
      // break;
      case 2:
        return const PublicScreen();
      // break;
      case 3:
        return ListaPost();
      // break;
      case 4:
        return LocationScreen();
      // break;
      default:
        return const ActivScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final UIController controllerUi = Get.find<UIController>();
    // int _selectedIndex = 0;
    Widget _content = const ActivScreen();
    Controllerauth controluser = Get.find();
    return Scaffold(
      appBar: CustomAppBar(
          picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
          tile: const Text("Peetoze"),
          controller: controllerUi,
          iconPets: Icon(Icons.pets),
          context: context,
          onSignOff: () async {
            await controluser.logOut();
            Get.offNamed('/auth');
          }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child:
                Obx(() => _getScreen(controllerUi.reactiveScreenIndex.value)),
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
          currentIndex: controllerUi.screenIndex,
          onTap: (index) {
            controllerUi.screenIndex = index;
          }),
    );
  }
}



// NavBar action

// We create a Scaffold that is used for all the content pages
// We only define one AppBar, and one scaffold.
