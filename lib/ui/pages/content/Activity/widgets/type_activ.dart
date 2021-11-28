import 'package:flutter/material.dart';
import 'package:red_egresados/ui/pages/content/Activity/widgets/activ_card.dart';

class ContentActy extends StatelessWidget {
  final String title;
  List<Widget> states;
  ContentActy({required this.title, required this.states});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: () {}, child: Text(title)),
        Column(
          children: states,
        )
      ],
    );
  }
}
