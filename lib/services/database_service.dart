import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/config/configuration.dart';
import 'package:topaz/models/message/message.dart';
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

  Future<void> deleteAccount(Account account) async {
    WriteBatch writeBatch = FirebaseFirestore.instance.batch();

    final accountRef = _userRef.collection('accounts').doc(account.id);

    final transactionsSnapshot = await _userRef
        .collection('transactions')
        .where('account.id', isEqualTo: account.id)
        .get();

    for (var transaction in transactionsSnapshot.docs) {
      writeBatch.delete(transaction.reference);
    }
    writeBatch.delete(accountRef);

    try {
      await writeBatch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Message>> messagetListStream() {
    return _userRef.collection('messages').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (messageListSnapshot) => Message.fromJson(
                  messageListSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  addConfiguration({required Configuration configuration}) async {
    final accountRef = _userRef.collection('configuration').doc();
    try {
      configuration.id = configuration.id;
      await accountRef.set(configuration.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
