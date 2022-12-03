import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:topaz/config/custom_theme.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/client/client.dart';
import 'package:topaz/models/message/message.dart';
import 'package:topaz/screens/account/account_screen.dart';
import 'package:topaz/screens/account/add_account_screen.dart';
import 'package:topaz/screens/auth/authenticate_screen.dart';
import 'package:topaz/screens/clients/add_client_screen.dart';
import 'package:topaz/services/client_db_service.dart';
import 'package:topaz/screens/clients/clients_screen.dart';
import 'package:topaz/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:topaz/services/database_service.dart';
import 'package:topaz/models/transaction/transaction.dart' as topaz;

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final customTheme = Provider.of<CustomTheme>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<Account>>.value(
            initialData: const [],
            value: user != null
                ? DatabaseService(uid: user.uid).accountListStream()
                : null),
        StreamProvider<List<topaz.Transaction>>.value(
            initialData: const [],
            value: user != null
                ? DatabaseService(uid: user.uid).transactionListStream()
                : null),
        StreamProvider<List<Message>>.value(
            initialData: const [],
            value: user != null
                ? DatabaseService(uid: user.uid).messagetListStream()
                : null),
        StreamProvider<List<Client>>.value(
            initialData: const [],
            value: user != null
                ? ClientDBService(uid: user.uid).messagetListStream()
                : null),
      ],
      child: MaterialApp(
        title: 'Topaz',
        initialRoute: '/',
        routes: {
          HomeScreen.routeName: ((context) => const HomeScreen()),
          ClientsScreen.routeName: ((context) => const ClientsScreen()),
          AddAccountScreen.routeName: ((context) => const AddAccountScreen()),
          AddClientScreen.routeName: ((context) => AddClientScreen()),
          AccountScreen.routeName: (context) => AccountScreen(
              selectedAccount: Provider.of<List<Account>>(context).first),
        },
        home: user != null ? const HomeScreen() : const AuthenticateScreen(),
        theme: customTheme.darkTheme,
        darkTheme: customTheme.darkTheme,
        themeMode: customTheme.currentTheme(),
      ),
    );
  }
}
