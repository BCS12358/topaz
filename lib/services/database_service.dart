import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topaz/models/account/account.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:topaz/models/transaction/transaction.dart' as topaz;

class DatabaseService {
  final String uid;
  final FirebaseFirestore _database;
  final DocumentReference _userRef;

  DatabaseService({required this.uid})
      : _database = FirebaseFirestore.instance,
        _userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  Stream<List<Account>> accountListStream() {
    return _userRef.collection('accounts').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (accountListSnapshot) => Account.fromJson(
                  accountListSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<topaz.Transaction>> transactionListStream() {
    return _userRef.collection('transactions').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (reminderSnapshot) => topaz.Transaction.fromJson(
                  reminderSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  addAccount({required Account account}) async {
    final accountRef = _userRef.collection('accounts').doc();
    try {
      account.id = accountRef.id;
      await accountRef.set(account.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(topaz.Transaction transaction) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final transactionRef =
        _userRef.collection('transactions').doc(transaction.id);
    batch.delete(transactionRef);
    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future addTransaction({required topaz.Transaction transaction}) async {
    final transactionRef = _userRef.collection('transactions').doc();

    transaction.id = transactionRef.id;

    WriteBatch batch = _database.batch();

    batch.set(transactionRef, transaction.toJson());

    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> deleteReminder(Reminder reminder, TodoList todoList) async {
  //   WriteBatch writeBatch = FirebaseFirestore.instance.batch();

  //   final remindersRef = _userRef.collection('reminders').doc(reminder.id);

  //   final listRef = _userRef.collection('todo_lists').doc(reminder.list['id']);

  //   writeBatch.delete(remindersRef);
  //   writeBatch.update(listRef, {'reminder_count': todoList.reminderCount - 1});

  //   try {
  //     await writeBatch.commit();
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
