class Post {
  final String texto;
  final DateTime fecha;
  final String name;

  Post(this.texto, this.fecha, this.name);

  Post.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        texto = json['texto'] as String,
        name = json['name'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'fecha': fecha.toString(),
        'texto': texto,
        'name': name,
      };
}
