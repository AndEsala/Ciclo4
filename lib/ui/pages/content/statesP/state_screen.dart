import 'package:flutter/material.dart';
import 'package:red_egresados/ui/pages/content/statesP/widgets/state_edit.dart';
import 'widgets/state_card.dart';

class StateScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const StateScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StateScreen> {
  final items = List<String>.generate(4, (i) => "Item $i");
  /* final textController = TextEditingController(); */

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StateEdit(),
        SizedBox(child: ListView(children: _states()), height: 450)
      ],
    );
  }

  List<Widget> _states() {
    List<Widget> estados = [];

    /* for (var i = 0; i < 10; i++) {
      Widget estado = StateCard(
        title: 'Estado de Didier',
        content: ' i am happy with my new pet :D ',
        picUrl:
            'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
        onChat: () => {},
      );

      estados.add(estado);
    } */

    return estados;
  }
}
