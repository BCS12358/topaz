// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/message/message.dart';
import 'package:topaz/screens/widgets/dismissible_background.dart';

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
  Widget build(BuildContext context) {
    final mesages = Provider.of<List<Message>>(context);
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
                itemCount: 30,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Dismissible(
                    background: const DismissibleBackground(),
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: ((direction) {
                      // try {
                      //   DatabaseService(uid: user!.uid)
                      //       .deleteTransaction(transactions[index]);
                      //   showSnackBar(context, "Transaction successfully deleted");
                      // } catch (ex) {
                      //   print(ex);
                      //   showSnackBar(context,
                      //       "Ops something went wrong! Transaction colt not be deleted");
                      // }
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
                                        'Highest expanse',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Your highest account asda bla bla bla bla bla bla bla.',
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
