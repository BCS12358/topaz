import 'package:flutter/material.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: 30,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return Card(
              child: ListTile(
                onTap: () {},
                leading: Text(index.toString()),
                title: Text(index.toString()),
                trailing: Text(index.toString()),
              ),
            );
          })),
    );
  }
}
