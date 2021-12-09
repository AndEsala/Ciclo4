import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:red_egresados/domain/controller/controlchat.dart';
import 'package:red_egresados/domain/models/message_model.dart';
import 'package:red_egresados/domain/controller/controllerauth.dart';

class MessageWidget extends StatelessWidget {
  final String texto;
  final DateTime fecha;
  final String name;
  final String idmensaje;
  final String uid;
  final String photo;

  MessageWidget(
      this.texto, this.fecha, this.name, this.idmensaje, this.uid, this.photo);

  @override
  Widget build(BuildContext context) {
    Controlchat controlchat = Get.find();
    Controllerauth controluser = Get.find();
    return Padding(
        padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 2),
        child: Column(children: [
          ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(photo),
            ),
            title: new Row(
              children: <Widget>[
                new Text(
                  texto,
                )
              ],
              mainAxisAlignment: (controluser.uid == uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
            ),
            subtitle: new Row(
              children: <Widget>[
                new Text(
                  name,
                )
              ],
              mainAxisAlignment: (controluser.uid == uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
            ),
            // trailing: Text(DateFormat('kk:mma').format(fecha).toString()),
            trailing: Text(formatdate(fecha)),
            onLongPress: () {
              if (controluser.uid == uid) {
                controlchat.deleteMensaje(idmensaje);
              }
            },
          ),
        ]));
  }
}
