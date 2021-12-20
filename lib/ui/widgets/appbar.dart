import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_peetoze/domain/use_cases/controllers/ui.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final String picUrl;
  final Widget tile;
  final Widget iconPets;
  final VoidCallback onSignOff;
  // final UIController controller;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar(
      {Key? key,
      required this.context,
      required this.picUrl,
      required this.tile,
      required this.iconPets,
      // required this.controller,
      required this.onSignOff})
      : super(
          key: key,
          centerTitle: true,
          leading: Center(
            child: CircleAvatar(
              minRadius: 18.0,
              maxRadius: 18.0,
              backgroundImage: NetworkImage(picUrl),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [iconPets, tile],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.brightness_4_rounded,
              ),
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                // controller.manager.changeTheme(isDarkMode: !Get.isDarkMode);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: onSignOff,
            )
          ],
        );
}
