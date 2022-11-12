// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: (() async {
                                    final canRemove =
                                        await removeAlertDialog(context);
                                    if (canRemove) {
                                      try {
                                        DatabaseService(uid: user!.uid)
                                            .deleteAccount(
                                                widget.selectedAccount);
                                        Navigator.of(context).pop();
                                        showSnackBar(context,
                                            'Account successfully deleted');
                                      } catch (err) {
                                        // ignore: avoid_print
                                        print(err);
                                      }
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
                                    .findColorById(
                                        widget.selectedAccount.icon['color'])
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
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TransactionListView(widget.selectedAccount),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.arrow_up_arrow_down,
              size: 30,
              color: CustomColorCollection()
                  .findColorById(widget.selectedAccount.icon['color'])
                  ?.color,
            ),
            label: 'New Transaction',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt_rounded),
            label: 'Filter',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.white,
        onTap: (value) {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTransactionScreen(
                  selectedAccount: widget.selectedAccount,
                ),
                fullscreenDialog: true,
              ),
            );
          }
        },
      ),
    );
  }
}
