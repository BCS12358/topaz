import 'package:flutter/material.dart';

class AccountListView extends StatelessWidget {
  const AccountListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        itemCount: 10,
        itemBuilder: ((context, index) {
          return _buildAccountCard(context, index);
        }),
        separatorBuilder: ((context, index) {
          return const SizedBox(
            width: 10,
          );
        }),
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context, int index) {
    return Card(
      child: SizedBox(
        height: 180,
        width: 150,
        child: Text(index.toString()),
      ),
    );
  }
}
