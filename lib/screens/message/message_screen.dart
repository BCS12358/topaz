// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/message/message.dart';
import 'package:topaz/screens/widgets/dismissible_background.dart';
import 'package:topaz/services/database_service.dart';
import 'package:topaz/utils/helpers.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<Message>>(context);
    final user = Provider.of<User?>(context);
    return Container(
      color: Colors.blueGrey.shade900,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 100, 0),
                  child: Text(
                    'Messages',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Dismissible(
                    background: const DismissibleBackground(),
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: ((direction) async {
                      try {
                        await DatabaseService(uid: user!.uid)
                            .deleteMessage(messages[index]);
                        // ignore: use_build_context_synchronously
                        showSnackBar(context, "Message successfully deleted");
                      } catch (ex) {
                        print(ex);
                        showSnackBar(context,
                            "Ops something went wrong! Message could not be deleted");
                      }
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey.shade800),
                      margin: EdgeInsets.all(5),
                      child: SizedBox(
                        height: 90, //todo would like to make it more dynamic
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.notifications,
                                  size: 30,
                                )),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        messages[index].title,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        messages[index].body,
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '09-12-2022 at 21:50',
                                        style: TextStyle(color: Colors.white70),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
