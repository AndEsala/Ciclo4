import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:red_egresados/ui/pages/content/Activity/widgets/type_activ.dart';
import 'widgets/activ_card.dart';

class ActivScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const ActivScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ActivScreen> {
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
            ElevatedButton(
              onPressed: () {
                Get.offNamed('/chats');
              },
              child: const Text('Chats'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, shape: StadiumBorder()),
            ),
            ContentActy(
              title: "Chats",
              states: const [],
              redirect: 'chats',
            ),
            TextButton(
                onPressed: () {
                  Get.offNamed('/notify');
                },
                child: Text('Notificaciones')),
            ContentActy(
              title: "Notificaciones",
              states: itemsNotify,
              redirect: 'notifys',
            ),
            TextButton(
                onPressed: () {
                  Get.offNamed('/adoption');
                },
                child: Text('Adopción')),
            ContentActy(
              title: "Adopción",
              states: itemsAdop,
              redirect: 'adopcion',
            )
          ],
        );
      },
    );
  }
}
