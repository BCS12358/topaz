// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/client/client.dart';
import 'package:topaz/screens/clients/add_client_screen.dart';
import 'package:topaz/screens/widgets/dismissible_background.dart';
import 'package:topaz/services/client_db_service.dart';
import 'package:topaz/utils/helpers.dart';

class ClientListView extends StatelessWidget {
  const ClientListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final List<Client> clients = Provider.of<List<Client>>(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
        itemCount: clients.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: const DismissibleBackground(),
            onDismissed: (direction) async {
              await ClientDBService(uid: user.uid)
                  .deleteMessage(clients[index]);
              showSnackBar(context, 'Client removed successfully');
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddClientScreen(
                      selectedClient: clients[index],
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                color: Colors.blueGrey.shade800,
                elevation: 14,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey.shade900,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(clients[index].name),
                  trailing: Text(clients[index].email),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
