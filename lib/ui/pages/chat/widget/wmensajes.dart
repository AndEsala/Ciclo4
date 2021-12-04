import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:red_egresados/domain/controller/controlchat.dart';
import 'package:red_egresados/domain/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final String texto;
  final DateTime fecha;
  final String name;

  MessageWidget(this.texto, this.fecha, this.name);

  @override
  Widget build(BuildContext context) {
    Controlchat controlchat = Get.find();
    return Padding(
        padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 2),
        child: Column(children: [
          ListTile(
            leading: CircleAvatar(
              radius: 15,
              child: Text('AV'),
            ),
            title: Text(texto),
            subtitle: Text(name),
            trailing: Text(formatdate(fecha)),
          ),
          //   Container(
          //       decoration: BoxDecoration(boxShadow: [
          //         BoxShadow(
          //             color: Colors.grey[350]!,
          //             blurRadius: 2.0,
          //             offset: Offset(0, 1.0))
          //       ], borderRadius: BorderRadius.circular(50.0), color: Colors.white),
          //       child: MaterialButton(
          //           disabledTextColor: Colors.black87,
          //           padding: EdgeInsets.only(left: 18),
          //           onPressed: null,
          //           onLongPress: () {},
          //           child: Wrap(
          //             children: <Widget>[
          //               Container(
          //                   child: Row(
          //                 children: [
          //                   Text(texto),
          //                 ],
          //               ))
          //             ],
          //           ))),
          //   Padding(
          //       padding: const EdgeInsets.only(top: 4),
          //       child: Align(
          //           alignment: Alignment.topRight,
          //           child: Text(
          //               name +
          //                   '-' +
          //                   DateFormat('kk:mma, dd-MM-yyyyy')
          //                       .format(fecha)
          //                       .toString(),
          //               style: TextStyle(color: Colors.grey))))
        ]));
  }
}
