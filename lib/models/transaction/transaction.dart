class Transaction {
  String? id;
  final String title;
  final double price;
  final int qtd;
  final Map<String, dynamic> account;
  final int txDate;
  final Map<String, dynamic> txTime;

  Transaction(
      {this.id,
      required this.title,
      required this.price,
      required this.qtd,
      required this.account,
      required this.txDate,
      required this.txTime}); //{hours: 10, minutes: 55}

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        qtd = json['qtd'],
        account = json['acccount'],
        txDate = json['tx_date'],
        txTime = json['tx_time'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'qtd': qtd,
        'account': account,
        'tx_date': txDate,
        'tx_time': txTime
      };
}
