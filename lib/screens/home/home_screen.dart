import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:topaz/screens/widgets/account_list_view.dart';
import 'package:topaz/screens/widgets/transaction_list_view.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              'Accounts',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const AccountListView(),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Divider(
              height: 5,
              thickness: 3.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Text(
              'Transactions',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(child: TransactionListView.emptyAccount())
        ],
      ),
    );
  }
}
