import 'package:flutter/material.dart';
import 'package:red_egresados/ui/pages/content/states/widgets/type_state.dart';
import 'widgets/state_card.dart';

class StatesScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const StatesScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StatesScreen> {
  final Icon icono = Icon(Icons.notifications);

  final stateCardChat = StateCard(
    title: 'Andrés',
    content: 'Lorem ipsum dolor sit amet.',
    picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
    icon: const Icon(Icons.chat),
    onChat: () => {},
  );

  final stateCardNotify = StateCard(
    title: 'Andrés',
    content: 'Lorem ipsum dolor sit amet.',
    picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
    icon: const Icon(Icons.notifications),
    onChat: () => {},
  );

  final stateCardAdop = StateCard(
    title: 'Andrés',
    content: 'Lorem ipsum dolor sit amet.',
    picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
    icon: const Icon(Icons.pets),
    onChat: () => {},
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        List<StateCard> itemsChats = [
          stateCardChat,
          stateCardChat,
          stateCardChat
        ];
        List<StateCard> itemsNotify = [
          stateCardNotify,
          stateCardNotify,
          stateCardNotify
        ];
        List<StateCard> itemsAdop = [
          stateCardAdop,
          stateCardAdop,
          stateCardAdop
        ];

        return Column(
          children: [
            ContentStates(title: "Chats", states: itemsChats),
            ContentStates(title: "Notificaciones", states: itemsNotify),
            ContentStates(title: "Adopción", states: itemsAdop)
          ],
        );
      },
    );
  }
}
