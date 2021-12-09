import 'package:intl/intl.Dart';

class Message {
  final String texto;
  final DateTime fecha;
  final String name;
  final String uid;
  final String photo;

  Message(this.texto, this.fecha, this.name, this.uid, this.photo);

  Message.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        texto = json['texto'] as String,
        name = json['name'] as String,
        uid = json['uid'] as String,
        photo = json['photo'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'fecha': fecha.toString(),
        'texto': texto,
        'name': name,
        'uid': uid,
        'photo': photo,
      };
}

// debo llamar este metodo para extraer la hora
String formatdate(fecha) {
  var formatter = new DateFormat.jm();
  String formatted = formatter.format(fecha);
  return formatted; // something like 04:34 pm
}
