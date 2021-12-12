import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:red_peetoze/domain/controller/control_state.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/models/user_states.dart';
import 'package:red_peetoze/ui/pages/content/statesP/widgets/new_state.dart';

import 'widgets/state_card.dart';

class StatesScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const StatesScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StatesScreen> {
  late final StatusManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream;
  late bool _isButtonDisabled;
  // late ConnectivityController controller;

  @override
  void initState() {
    super.initState();
    manager = StatusManager();
    statusesStream = manager.getStatusesStream();
    _isButtonDisabled = false;
    // controller = Get.find<ConnectivityController>();
  }

  @override
  Widget build(BuildContext context) {
    Controllerauth controluser = Get.find();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: Center(
              child: ElevatedButton(
                child: const Text("Agregar Estado"),
                onPressed: () {
                  Get.dialog(
                    PublishDialog(
                      manager: manager,
                    ),
                  );
                  // We don't allow to trigger the action if we don't have connectivity
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: statusesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final items = manager.extractStatuses(snapshot.data!);
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      UserStatus status = items[index];
                      return StateCard(
                          title: status.name,
                          uid: controluser.uid,
                          content: status.message,
                          picUrl: status.picUrl,
                          onDelete: () {
                            print("por aqui paso");
                          },
                          icon: IconButton(
                            onPressed: () {
                              if (status.uid == controluser.uid) {
                                _isButtonDisabled = true;
                                print("es el mismo uid: " + status.uid);
                                manager.removeStatus(status);
                              } else {
                                _isButtonDisabled = true;
                                print("no es el mismo uid" +
                                    controluser.uid +
                                    " - " +
                                    status.uid);
                              }
                            },
                            icon: status.uid == controluser.uid
                                ? Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.brightness_1_rounded,
                                    color: Colors.black,
                                    size: 10.0,
                                  ),
                          ));
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Something went wrong: ${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
