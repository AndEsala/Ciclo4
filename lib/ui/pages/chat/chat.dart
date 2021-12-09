import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/controller/controlchat.dart';
import 'package:red_egresados/domain/controller/controllerauth.dart';
import 'package:red_egresados/domain/models/message_model.dart';
import 'package:red_egresados/ui/pages/chat/widget/wmensajes.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _mensajeController = TextEditingController();
  Controlchat controlchat = Get.find();
  Controllerauth controluser = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollHaciaAbajo());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offNamed('/content');
              },
              icon: Icon(Icons.chevron_left)),
          title: const Text('Chat Peetoze'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              _getListaMensajes(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                            keyboardType: TextInputType.text,
                            controller: _mensajeController,
                            onChanged: (text) => setState(() {}),
                            onSubmitted: (input) {
                              _enviarMensaje();
                            },
                            decoration: const InputDecoration(
                                hintText: 'Escribe un mensaje')))),
                IconButton(
                    icon: Icon(_puedoEnviarMensaje()
                        ? CupertinoIcons.arrow_right_circle_fill
                        : CupertinoIcons.arrow_right_circle),
                    onPressed: () {
                      _enviarMensaje();
                    })
              ]),
            ])));
  }

  void _enviarMensaje() {
    if (_puedoEnviarMensaje()) {
      final mensaje = Message(_mensajeController.text, DateTime.now(),
          controluser.name, controluser.uid, controluser.photorul);
      controlchat.guardarMensaje(mensaje);
      _mensajeController.clear();
      setState(() {});
    }
  }

  bool _puedoEnviarMensaje() => _mensajeController.text.length > 0;

  Widget _getListaMensajes() {
    return Expanded(
        child: FirebaseAnimatedList(
      controller: _scrollController,
      query: controlchat.getMensajes(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        print('Id_unico:${snapshot.key}');
        var idmensaje = snapshot.key;

        final mensaje = Message.fromJson(json);
        return MessageWidget(mensaje.texto, mensaje.fecha, mensaje.name,
            idmensaje!, mensaje.uid, mensaje.photo);
      },
    ));
  }

  void _scrollHaciaAbajo() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
