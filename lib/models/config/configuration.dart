class Configuration {
  String? id;
  final String token;

  Configuration({this.id, required this.token});

  Configuration.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        token = json['token'];

  Map<String, dynamic> toJson() => {'id': id, 'token': token};
}
