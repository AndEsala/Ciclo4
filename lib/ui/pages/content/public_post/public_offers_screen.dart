import 'package:flutter/material.dart';
import 'widgets/offer_card.dart';

class PublicScreen extends StatefulWidget {
  // PublicOffersScreen empty constructor
  const PublicScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PublicScreen> {
  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return OfferCard(
          title: 'Desarrollador backend de NodeJs',
          content:
              'Estamos buscando un desarrollador backend independiente de NodeJS para trabajar en el backend de una aplicación nativa de Android. Alguien que pueda ayudarnos en la creación de una aplicación móvil de redes sociales basada en video desde cero. Este sería un puesto remunerado con la opción de trabajar desde casa. Una oportunidad de aprender y desarrollar algo desde cero.',
          arch: 'Android',
          level: 'Experto',
          payment: 3000000,
          onCopy: () => {},
          onApply: () => {},
        );
      },
    );
  }
}
