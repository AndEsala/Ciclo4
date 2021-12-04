import 'package:flutter/material.dart';

class PostEdit extends StatelessWidget {
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
          maxLength: 255,
          maxLines: 10,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.edit),
              alignLabelWithHint: false,
              hintText: 'Publica tu Post',
              helperText: 'Post'),
        ),
        // ElevatedButton(onPressed: () {}, child: Text('Publicar'))
      ),
      ElevatedButton(
        onPressed: () {},
        child: const Text('Publicar'),
        style: ElevatedButton.styleFrom(
            primary: Colors.blue, shape: StadiumBorder()),
      ),
    ]);
  }
}
