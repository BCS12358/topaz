import 'dart:math';

import 'package:topaz/models/transaction/transaction.dart';

class AccountUtils {
  static num getHighest({required List<Transaction> transactions}) {
    if (transactions.isEmpty) {
      return 0;
    }
    return transactions.map((tx) => tx.price * tx.qtd).reduce(max);
  }

  static num getLowest({required List<Transaction> transactions}) {
    if (transactions.isEmpty) {
      return 0;
    }

    return transactions.map((tx) => tx.price * tx.qtd).reduce(min);
  }

  static num totalIncoming({required List<Transaction> transactions}) {
    if (transactions.isEmpty) {
      return 0;
    }
    return transactions
        .where((tx) => tx.incoming)
        .map((tx) => tx.price * tx.qtd)
        .fold(0.0, (a, b) => a + b);
  }

  static num getNumberSales({required List<Transaction> transactions}) {
    if (transactions.isEmpty) {
      return 0;
    }
    return transactions.where((tx) => tx.incoming == true).toList().length;
  }

  static num getNumberPurchase({required List<Transaction> transactions}) {
    if (transactions.isEmpty) {
      return 0;
    }
    return transactions.where((tx) => tx.incoming == false).toList().length;
  }

  static num totalOutgoing({required List<Transaction> transactions}) {
    if (transactions.isEmpty) {
      return 0;
    }

    return transactions
        .where((tx) => tx.incoming == false)
        .map((tx) => tx.price * tx.qtd)
        .fold(0.0, (a, b) => a + b);
  }
}
