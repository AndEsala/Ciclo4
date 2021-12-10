import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_peetoze/domain/controller/controllerauth.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';
import 'package:red_peetoze/ui/pages/content/post/widgets/add_post.dart';

import 'package:red_peetoze/ui/pages/content/post/widgets/edit_post.dart';

import 'package:get/get.dart';

class ListaPost extends StatefulWidget {
  @override
  _ListaPostState createState() => _ListaPostState();
}

class _ListaPostState extends State<ListaPost> {
  ControllerFirestore controlp = Get.find();
  Controllerauth controluser = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getInfo(context, controlp.readItems(), controluser.uid),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AgregarPost());
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid) {
  return StreamBuilder(
    stream: ct,
    /*FirebaseFirestore.instance
        .collection('clientes')
        .snapshots(),*/ //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      print(snapshot.connectionState);
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaEstados(post: snapshot.data!.docs, uid: uid)
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class VistaEstados extends StatelessWidget {
  final List post;
  final String uid;
  const VistaEstados({required this.post, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: post.length == 0 ? 0 : post.length,
        itemBuilder: (context, posicion) {
          print(post[posicion].id);
          return Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 16.0, left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(post[posicion]['photo']),
                      ),
                      const SizedBox(
                        width: 14.0,
                      ),
                      Expanded(
                        child: Text(
                          post[posicion]['titulo'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      (uid == post[posicion]['uid'])
                          ? IconButton(
                              onPressed: () {
                                Get.to(() => ModificarPost(
                                      post: post,
                                      pos: posicion,
                                      iddoc: post[posicion].id,
                                    ));
                              },
                              icon: Icon(Icons.edit))
                          : Text(''),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(post[posicion]['detalle']),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    child: Image.network(post[posicion]['fotopost']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(post[posicion]['name']),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
