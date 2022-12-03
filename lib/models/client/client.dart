class Client {
  String? id;
  final String name;
  final String phone;
  final String email;

  Client(
      {this.id, required this.name, required this.phone, required this.email});

  Client.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };
}
