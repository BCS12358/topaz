import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/screens/message/message_screen.dart';
import 'package:topaz/screens/settings/settings_menu_screen.dart';
import 'package:topaz/screens/widgets/account_list_view.dart';
import 'package:topaz/screens/widgets/notification_icon.dart';
import 'package:topaz/screens/widgets/transaction_list_view.dart';

import '../../models/message/message.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<Message>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: NotificationIcon(
          iconData: Icons.email_outlined,
          size: 15,
          number: messages.length,
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ));
            },
          )
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
      drawer: const Drawer(
        child: MessageScreen(),
      ),
      endDrawer: const Drawer(
        child: SettingsMenuScreen(),
      ),
      // onEndDrawerChanged: ((isOpened) {}),
    );
  }
}
