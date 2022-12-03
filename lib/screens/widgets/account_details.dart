import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/account/accountUtils.dart';
import 'package:topaz/models/transaction/transaction.dart';
import 'package:topaz/utils/helpers.dart';

class AccountDetails extends StatelessWidget {
  final Account selectedAccount;
  // ignore: use_key_in_widget_constructors
  const AccountDetails({required this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    final allTransactions = Provider.of<List<Transaction>>(context);
    final selectedAccountTransactions = allTransactions
        .where((tx) => tx.account['id'] == selectedAccount.id)
        .toList();

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: PageView.builder(
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
                    child: Container(child: _buildCardTitleDetails(1, context)),
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
                      description: 'Sell',
                      total: AccountUtils.totalIncoming(
                          transactions: selectedAccountTransactions),
                      icon: Icons.arrow_upward,
                      formatAsMoney: true,
                    ),
                    AccountDetailWidget(
                      selectedAccount: selectedAccount,
                      description: 'Buy',
                      total: AccountUtils.totalOutgoing(
                          transactions: selectedAccountTransactions),
                      icon: Icons.arrow_downward,
                      formatAsMoney: true,
                    ),
                    AccountDetailWidget(
                      selectedAccount: selectedAccount,
                      description: 'No. Sell',
                      total: AccountUtils.getNumberSales(
                          transactions: selectedAccountTransactions),
                      icon: Icons.circle,
                      formatAsMoney: false,
                    ),
                    AccountDetailWidget(
                      selectedAccount: selectedAccount,
                      description: 'No. Buy',
                      total: AccountUtils.getNumberPurchase(
                          transactions: selectedAccountTransactions),
                      icon: Icons.circle_outlined,
                      formatAsMoney: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildCardTitleDetails(int index, BuildContext context) {
    if (index == 1) {
      return Text('Weekly', style: _cardDetailsTitleStyle());
    }
    if (index == 2) {
      return Text('Monthly', style: _cardDetailsTitleStyle());
    }
    return Text('Annual', style: _cardDetailsTitleStyle());
  }
}

TextStyle _cardDetailsTitleStyle() {
  return const TextStyle(
      fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold);
}

class AccountDetailWidget extends StatelessWidget {
  const AccountDetailWidget({
    Key? key,
    required this.selectedAccount,
    required this.icon,
    required this.description,
    required this.total,
    required this.formatAsMoney,
  }) : super(key: key);

  final Account selectedAccount;
  final IconData icon;
  final String description;
  final num total;
  final bool formatAsMoney;

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
                color: Colors.blueGrey.shade900,
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
              formatAsMoney ? formatNumberAsMoney(total) : total.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
