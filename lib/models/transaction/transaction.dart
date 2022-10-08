import 'package:topaz/models/account/account.dart';

class Transaction {
  String? id;
  final String title;
  final double price;
  final int qtd;
  final bool incoming;
  final Map<String, dynamic> account;
  final int txDate;
  final Map<String, dynamic> txTime;

  Transaction(
      {this.id,
      required this.title,
      required this.price,
      required this.qtd,
      required this.account,
      required this.incoming,
      required this.txDate,
      required this.txTime}); //{hours: 10, minutes: 55}

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        qtd = json['qtd'],
        incoming = json['incoming'],
        account = json['account'],
        txDate = json['tx_date'],
        txTime = json['tx_time'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'qtd': qtd,
        'incoming': incoming,
        'account': account,
        'tx_date': txDate,
        'tx_time': txTime
      };

  num get totalPrice {
    return price * qtd;
  }

  static List<Transaction> getTransactionByAccount(
      Account? account, List<Transaction> transactions) {
    if (account == null) {
      return transactions;
    }
    return transactions
        .where(
          (t) => t.account['id'] == account.id,
        )
        .toList();
  }

  static num getTotalTransactionByAccount(
      Account account, List<Transaction> transactions) {
    return transactions
        .where((t) => t.account['id'] == account.id)
        .map((t) => t.price * t.qtd)
        .fold(0.0, (a, b) => a + b);
  }
}
