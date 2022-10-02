class Account {
  String? id;
  final String name;
  final Map icon;

  Account({required this.id, required this.name, required this.icon});

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'icon': icon};
}
