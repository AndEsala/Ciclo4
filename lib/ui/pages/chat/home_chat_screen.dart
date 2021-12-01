import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/models/message_model.dart';
import 'package:red_egresados/ui/pages/chat/widgets/category_selector.dart';
import 'package:red_egresados/ui/pages/chat/widgets/contacts.dart';
import 'package:red_egresados/ui/pages/chat/widgets/recent_chats.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat Peetoze',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.chevron_left_outlined),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () {}),
              title: Text(
                'Chats',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () {}),
              ],
            ),
            body: Column(children: <Widget>[
              CategorySelector(),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Contacts(),
                          RecentChats(),
                        ],
                      ))),
            ])));
  }
}
