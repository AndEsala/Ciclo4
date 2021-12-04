import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:red_egresados/ui/pages/content/Activity/widgets/activ_card.dart';

class ContentActy extends StatelessWidget {
  final String title;
  final String redirect;
  List<Widget> states;
  ContentActy(
      {Key? key,
      required this.title,
      required this.states,
      required this.redirect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: states,
        )
      ],
    );
  }
}
