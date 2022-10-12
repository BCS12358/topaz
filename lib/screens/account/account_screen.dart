import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/account/accountUtils.dart';
import 'package:topaz/models/common/custom_color_collection.dart';
import 'package:topaz/models/common/custom_icon_collection.dart';
import 'package:topaz/models/transaction/transaction.dart';
import 'package:topaz/screens/transaction/add_transaction_screen.dart';
import 'package:topaz/screens/widgets/account_details.dart';
import 'package:topaz/screens/widgets/transaction_list_view.dart';
import 'package:topaz/services/database_service.dart';
import 'package:topaz/utils/helpers.dart';

class AccountScreen extends StatefulWidget {
  static String routeName = '/account';

  final Account selectedAccount;

  // ignore: use_key_in_widget_constructors
  const AccountScreen({required this.selectedAccount});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final allTransactions = Provider.of<List<Transaction>>(context);
    final totalTransactions = Transaction.getTotalTransactionByAccount(
        widget.selectedAccount, allTransactions);

    final hasTransactions = AccountUtils.hasTransactions(
        transactions: allTransactions, selectedAccount: widget.selectedAccount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasTransactions
              ? Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Card(
                            color: Colors.blueGrey.shade800,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: (() {
                                          try {
                                            DatabaseService(uid: user!.uid)
                                                .deleteAccount(
                                                    widget.selectedAccount);
                                            Navigator.pop(context);
                                            showSnackBar(context,
                                                'Account successfully deleted');
                                          } catch (err) {
                                            // ignore: avoid_print
                                            print(err);
                                          }
                                        }),
                                        icon: const Icon(
                                          Icons.highlight_remove_sharp,
                                          color: Colors.grey,
                                        ),
                                        tooltip: 'Remove',
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CustomColorCollection()
                                          .findColorById(widget
                                              .selectedAccount.icon['color'])
                                          ?.color),
                                  child: Icon(CustomIconCollection()
                                      .findCustomItembyId(
                                          widget.selectedAccount.icon['icon'])
                                      ?.iconData),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.selectedAccount.name,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  totalTransactions.toString(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: AccountDetails(
                            selectedAccount: widget.selectedAccount,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: Text('')),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TransactionListView(widget.selectedAccount),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionScreen(
                selectedAccount: widget.selectedAccount,
              ),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.indigo,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.attach_money_sharp),
      //       label: 'Transaction',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Account',
      //     ),
      //   ],
      //   currentIndex: 1,
      //   selectedItemColor: Colors.white,
      //   onTap: (value) {},
      // ),
    );
  }
}
