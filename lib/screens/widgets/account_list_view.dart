import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/common/custom_color_collection.dart';
import 'package:topaz/models/common/custom_icon_collection.dart';
import 'package:topaz/models/transaction/transaction.dart';
import 'package:topaz/screens/account/account_screen.dart';
import 'package:topaz/screens/account/add_account_screen.dart';
import 'package:topaz/utils/helpers.dart';

class AccountListView extends StatelessWidget {
  const AccountListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<List<Account>>(context);
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        itemCount: accounts.isEmpty ? 1 : accounts.length,
        itemBuilder: ((context, index) {
          if (accounts.isEmpty || index == 0) {
            return _buildAddNewAccountCard(context);
          }

          return _buildAccountCard(context, accounts[index]);
        }),
        separatorBuilder: ((context, index) {
          return const SizedBox(
            width: 10,
          );
        }),
      ),
    );
  }

  Widget _buildAddNewAccountCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddAccountScreen(),
            fullscreenDialog: true,
          ),
        );
      },
      child: Card(
        elevation: 10,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 180,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [
                Expanded(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.blueGrey, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'New Account',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context, Account account) {
    final totalTransactions = Transaction.getTotalTransactionByAccount(
        account, Provider.of<List<Transaction>>(context));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountScreen(
              selectedAccount: account,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.blueGrey.shade800,
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 180,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: 50,
                    height: 50,
                    // padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: CustomColorCollection()
                            .findColorById(account.icon['color'])
                            ?.color,
                        shape: BoxShape.circle),
                    child: Icon(
                      CustomIconCollection()
                          .findCustomItembyId(account.icon['icon'])
                          ?.iconData,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  formatNumberAsMoney(totalTransactions),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(account.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
