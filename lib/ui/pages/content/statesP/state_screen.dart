import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:red_egresados/domain/controller/control_state.dart';
import 'package:red_egresados/domain/controller/controllerauth.dart';
import 'package:red_egresados/domain/models/user_states.dart';
import 'package:red_egresados/ui/pages/content/statesP/widgets/new_state.dart';

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
  // late ConnectivityController controller;

  @override
  void initState() {
    super.initState();
    manager = StatusManager();
    statusesStream = manager.getStatusesStream();
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
                          if (controluser.uid == controluser.uid) {
                            manager.removeStatus(status);
                          }
                        },
                      );
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
