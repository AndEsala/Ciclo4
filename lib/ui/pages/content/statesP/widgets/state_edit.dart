// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:red_egresados/domain/controller/control_state.dart';
// import 'package:red_egresados/domain/models/user_states.dart';
// import 'package:red_egresados/ui/pages/content/statesP/widgets/new_state.dart';
// import 'package:red_egresados/ui/pages/content/statesP/widgets/state_card.dart';

// class StateEdit extends StatefulWidget {
//   @override
//   State<StateEdit> createState() => _StateEditState();
// }

// class _StateEditState extends State<StateEdit> {
//   final textController = TextEditingController();
//   late final StatusManager manager;
//   late Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream;

//   @override
//   void initState() {
//     super.initState();
//     manager = StatusManager();
//     statusesStream = manager.getStatusesStream();
//     // controller = Get.find<ConnectivityController>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
//           child: Center(
//             child: ElevatedButton(
//               child: const Text("Agregar Estado"),
//               onPressed: () {
//                 Get.dialog(
//                   PublishDialog(
//                     manager: manager,
//                   ),
//                 );
//                 // We don't allow to trigger the action if we don't have connectivity
//               },
//             ),
//           ),
//         ),
//         Expanded(
//           child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//             stream: statusesStream,
//             builder: (BuildContext context,
//                 AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//               if (snapshot.hasData) {
//                 final items = manager.extractStatuses(snapshot.data!);
//                 return ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     UserStatus status = items[index];
//                     return StateCard(
//                       title: status.name,
//                       content: status.message,
//                       picUrl: status.picUrl,
//                       onDelete: () {
//                         manager.removeStatus(status);
//                       },
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Something went wrong: ${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const Center(child: CircularProgressIndicator());
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
    









    
    
    
// //      Column(children: [
// //       Container(
// //         padding: const EdgeInsets.all(8.0),
// //         child: TextField(
// //           controller: textController,
// //           autofocus: false,
// //           keyboardType: TextInputType.text,
// //           textInputAction: TextInputAction.send,
// //           autocorrect: true,
// //           textCapitalization: TextCapitalization.words,
// //           textAlign: TextAlign.left,
// //           maxLength: 55,
// //           // maxLines: 3,
// //           decoration: const InputDecoration(
// //               prefixIcon: Icon(Icons.edit),
// //               hintText: 'Publica tu Estado',
// //               helperText: 'Estado'),
// //         ),
// //         // ElevatedButton(onPressed: () {}, child: Text('Publicar'))
// //       ),
// //       ElevatedButton(
// //         onPressed: () {},
// //         child: const Text('Publicar'),
// //         style: ElevatedButton.styleFrom(
// //             primary: Colors.blue, shape: StadiumBorder()),
// //       ),
// //     ]);
// //   }
// // }
