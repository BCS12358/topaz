import 'package:flutter/material.dart';
import 'package:topaz/screens/clients/add_client_screen.dart';

import '../widgets/client_list_view.dart';

class ClientsScreen extends StatefulWidget {
  static String routeName = '/clients';

  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.popAndPushNamed(context, AddClientScreen.routeName),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: const Icon(
              Icons.people,
              size: 70,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: ClientListView(),
          ),
        ],
      ),
    );
  }
}
