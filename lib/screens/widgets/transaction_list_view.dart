// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/common/custom_color_collection.dart';
import 'package:topaz/models/transaction/transaction.dart';
import 'package:topaz/screens/widgets/dismissible_background.dart';
import 'package:topaz/services/database_service.dart';
import 'package:topaz/utils/helpers.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class TransactionListView extends StatelessWidget {
  Account? selectedAccount;

  // ignore: use_key_in_widget_constructors
  TransactionListView(this.selectedAccount);

  // ignore: use_key_in_widget_constructors
  TransactionListView.emptyAccount() : selectedAccount = null;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final transactions = Transaction.getTransactionByAccount(
        selectedAccount, Provider.of<List<Transaction>>(context));
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
          itemCount: transactions.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return Dismissible(
              background: const DismissibleBackground(),
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: ((direction) {
                try {
                  DatabaseService(uid: user!.uid)
                      .deleteTransaction(transactions[index]);
                  showSnackBar(context, "Transaction successfully deleted");
                } catch (ex) {
                  print(ex);
                  showSnackBar(context,
                      "Ops something went wrong! Transaction colt not be deleted");
                }
              }),
              child: Card(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 1),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListTile(
                  onTap: () {},
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: CustomColorCollection()
                            .findTransactionColorByAccount(
                                Account.fromJson(transactions[index].account))!
                            .color,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      // backgroundColor: Colors.black,
                      child: Icon(
                        transactions[index].incoming
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        transactions[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(formatDate(transactions[index].txDate)),
                  trailing: Text(
                    formatNumberAsMoney(transactions[index].totalPrice),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            );
          })),
    );
  }
}
