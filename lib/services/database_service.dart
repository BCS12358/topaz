import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topaz/models/account/account.dart';

import 'package:firebase_auth/firebase_auth.dart';

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

  // Stream<List<Reminder>> reminderStream() {
  //   return _userRef.collection('reminders').snapshots().map(
  //         (snapshot) => snapshot.docs
  //             .map(
  //               (reminderSnapshot) => Reminder.fromJson(
  //                 reminderSnapshot.data(),
  //               ),
  //             )
  //             .toList(),
  //       );
  // }

  addAccount({required Account account}) async {
    final accountRef = _userRef.collection('accounts').doc();
    try {
      account.id = accountRef.id;
      await accountRef.set(account.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> deleteTodoList(TodoList todoList) async {
  //   WriteBatch batch = FirebaseFirestore.instance.batch();

  //   final todoListRef = _userRef.collection('todo_lists').doc(todoList.id);

  //   final remindersSnapshot = await _userRef
  //       .collection('reminders')
  //       .where('list.id', isEqualTo: todoList.id)
  //       .get();

  //   remindersSnapshot.docs.forEach((reminder) {
  //     batch.delete(reminder.reference);
  //   });
  //   batch.delete(todoListRef);
  //   try {
  //     await batch.commit();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future addReminder({required Reminder reminder}) async {
  //   final reminderRef = _userRef.collection('reminders').doc();
  //   reminder.id = reminderRef.id;
  //   final listRef = _userRef.collection('todo_lists').doc(reminder.list['id']);

  //   WriteBatch batch = _database.batch();
  //   batch.set(reminderRef, reminder.toJson());
  //   batch.update(
  //       listRef, {'reminder_count': reminder.list['reminder_count'] + 1});
  //   try {
  //     await batch.commit();
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

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
