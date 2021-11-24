import 'package:flutter/material.dart';
import 'widgets/state_card.dart';

class StateScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const StateScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StateScreen> {
  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return StateCard(
          title: 'Estado de Didier',
          content: ' i am happy with my new pet :D ',
          picUrl:
              'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
          onChat: () => {},
        );
      },
    );
  }
}
