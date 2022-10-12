import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/account/accountUtils.dart';
import 'package:topaz/models/common/custom_color_collection.dart';
import 'package:topaz/models/transaction/transaction.dart';
import 'package:topaz/utils/helpers.dart';

class AccountDetails extends StatelessWidget {
  final Account selectedAccount;
  // ignore: use_key_in_widget_constructors
  const AccountDetails({required this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<Transaction>>(context);
    return PageView.builder(
      // itemCount: 3,
      itemCount: 1,
      itemBuilder: (context, index) => Card(
        color: Colors.blueGrey.shade800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueGrey.shade800,
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor),
                      child: _buildCardTitleDetails(index, context)),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AccountDetailWidget(
                    selectedAccount: selectedAccount,
                    description: 'Incoming',
                    total: AccountUtils.totalIncoming(
                        transactions: transactions,
                        selectedAccount: selectedAccount),
                    icon: Icons.arrow_upward,
                  ),
                  AccountDetailWidget(
                    selectedAccount: selectedAccount,
                    description: 'Outgoing',
                    total: AccountUtils.totalOutgoing(
                        transactions: transactions,
                        selectedAccount: selectedAccount),
                    icon: Icons.arrow_downward,
                  ),
                  // AccountDetailWidget(
                  //   selectedAccount: selectedAccount,
                  //   description: 'Median',
                  //   total: '33%',
                  //   icon: Icons.bar_chart_outlined,
                  // ),
                  AccountDetailWidget(
                    selectedAccount: selectedAccount,
                    description: 'Highest',
                    total: AccountUtils.getHighest(
                        transactions: transactions,
                        selectedAccount: selectedAccount),
                    icon: Icons.circle,
                  ),
                  AccountDetailWidget(
                    selectedAccount: selectedAccount,
                    description: 'Lowest',
                    total: AccountUtils.getLowest(
                        transactions: transactions,
                        selectedAccount: selectedAccount),
                    icon: Icons.circle_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildCardTitleDetails(int index, BuildContext context) {
    if (index == 1) {
      return Text(
        'Weekly',
        style: Theme.of(context).textTheme.bodyLarge,
      );
    }
    if (index == 2) {
      return Text(
        'Monthly',
        style: Theme.of(context).textTheme.bodyLarge,
      );
    }
    return Text(
      'All',
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class AccountDetailWidget extends StatelessWidget {
  const AccountDetailWidget({
    Key? key,
    required this.selectedAccount,
    required this.icon,
    required this.description,
    required this.total,
  }) : super(key: key);

  final Account selectedAccount;
  final IconData icon;
  final String description;
  final num total;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: CustomColorCollection()
                      .findTransactionColorByAccount(selectedAccount)!
                      .color,
                  width: 3,
                ),
              ),
              child: Icon(
                size: 16.0,
                icon,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              formatNumberAsMoney(total),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
