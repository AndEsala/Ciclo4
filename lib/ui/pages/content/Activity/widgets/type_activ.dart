import 'package:flutter/material.dart';
import 'package:red_egresados/ui/pages/content/Activity/widgets/activ_card.dart';

class ContentStates extends StatelessWidget {
  final String title;
  List<Widget> states;
  ContentStates({required this.title, required this.states});

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
