import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:red_peetoze/domain/controller/firestore.dart';

class ModificarPost extends StatefulWidget {
  final iddoc;
  final pos;
  final List post;
  ModificarPost({required this.post, this.pos, this.iddoc});

  @override
  _ModificarPostState createState() => _ModificarPostState();
}

class _ModificarPostState extends State<ModificarPost> {
  TextEditingController controltitulo = TextEditingController();
  TextEditingController controldetalle = TextEditingController();
  ControllerFirestore controlestados = Get.find();

  @override
  void initState() {
    controltitulo =
        TextEditingController(text: widget.post[widget.pos]['titulo']);
    controldetalle =
        TextEditingController(text: widget.post[widget.pos]['detalle']);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Mensajero"),
        actions: [
          IconButton(
              tooltip: 'Eliminar Cliente',
              icon: Icon(Icons.delete),
              onPressed: () {
                controlestados.eliminarestados(widget.post[widget.pos].id);
                Get.back();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: controltitulo,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: controldetalle,
                decoration: InputDecoration(labelText: "Detalle"),
              ),
              ElevatedButton(
                child: Text("Modificar Mensajero"),
                onPressed: () {
                  var estado = <String, dynamic>{
                    'titulo': controltitulo.text,
                    'detalle': controldetalle.text,
                  };

                  controlestados.actualizarestado(
                      widget.post[widget.pos].id, estado);

                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
