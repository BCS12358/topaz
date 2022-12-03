import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:topaz/screens/clients/clients_screen.dart';

class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 100, 0),
                child: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Scaffold(
            body: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, ClientsScreen.routeName);
                  },
                  child: Card(
                    color: Colors.blue.shade800,
                    child: const ListTile(
                      leading: Text('Clients'),
                      trailing: Icon(
                        Icons.supervisor_account,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Card(
                    color: Colors.blue.shade800,
                    child: const ListTile(
                      leading: Text('Logout'),
                      trailing: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
