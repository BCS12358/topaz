import 'dart:math';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/transaction/transaction.dart';

class AccountUtils {
  static num getHighest(
      {required List<Transaction> transactions,
      required Account selectedAccount}) {
    return transactions
        .where((tx) => tx.account['id'] == selectedAccount.id)
        .map((tx) => tx.price * tx.qtd)
        .reduce(max);
  }

  static getLowest(
      {required List<Transaction> transactions,
      required Account selectedAccount}) {
    return transactions
        .where((tx) => tx.account['id'] == selectedAccount.id)
        .map((tx) => tx.price * tx.qtd)
        .reduce(min);
  }

  static bool hasTransactions(
      {required List<Transaction> transactions,
      required Account selectedAccount}) {
    int hasTransactions =
        transactions.indexWhere((tx) => tx.account['id'] == selectedAccount.id);

    return hasTransactions == -1 ? false : true;
  }

  static num totalIncoming(
      {required List<Transaction> transactions,
      required Account selectedAccount}) {
    return transactions
        .where((tx) => tx.account['id'] == selectedAccount.id)
        .where((tx) => tx.incoming)
        .map((tx) => tx.price * tx.qtd)
        .fold(0.0, (a, b) => a + b);
  }

  static num totalOutgoing(
      {required List<Transaction> transactions,
      required Account selectedAccount}) {
    return transactions
        .where((tx) => tx.account['id'] == selectedAccount.id)
        .where((tx) => tx.incoming == false)
        .map((tx) => tx.price * tx.qtd)
        .fold(0.0, (a, b) => a + b);
  }
}
