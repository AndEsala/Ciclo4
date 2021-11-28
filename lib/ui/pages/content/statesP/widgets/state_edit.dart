import 'package:flutter/material.dart';

class StateEdit extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: textController,
          autofocus: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.send,
          autocorrect: true,
          textCapitalization: TextCapitalization.words,
          textAlign: TextAlign.left,
          maxLength: 55,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.edit),
            hintText: 'Publica tu Estado',
            helperText: 'Estado',
          ),
        ),
      ),
      ElevatedButton(onPressed: () {}, child: Text('Publicar'))
    ]);
  }
}
