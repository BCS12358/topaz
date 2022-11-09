class Message {
  String? id;
  final String title;
  final String body;
  final int creationDate;
  final Map<String, dynamic> creationTime;

  Message({
    this.id,
    required this.title,
    required this.body,
    required this.creationDate,
    required this.creationTime,
  });

  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        body = json['body'],
        creationDate = json['creationDate'],
        creationTime = json['creationTime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'creationDate': creationDate,
        'creationTime': creationTime
      };
}
