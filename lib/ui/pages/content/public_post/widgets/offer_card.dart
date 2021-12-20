import 'package:flutter/material.dart';
import 'package:red_peetoze/ui/widgets/card.dart';

class OfferCard extends StatelessWidget {
  final String title, content, pet;
  final int payment;

  // OfferCard constructor
  const OfferCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.pet,
      required this.payment})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return AppCard(
      title: title,
      content: Image(
        image: NetworkImage(content),
      ),
      extraContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.pets,
                  color: primaryColor,
                ),
              ),
              Text(
                pet,
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.payments_outlined,
                  color: primaryColor,
                ),
              ),
              Text(
                '\$$payment',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
