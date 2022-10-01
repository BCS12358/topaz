import 'package:flutter/material.dart';
import 'package:topaz/screens/account/add_account_screen.dart';

class AccountListView extends StatelessWidget {
  const AccountListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        itemCount: 2,
        itemBuilder: ((context, index) {
          return index < 1
              ? _buildAccountCard(context, index)
              : _buildAddNewAccountCard(context);
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
        child: SizedBox(
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
                        color: Colors.grey, shape: BoxShape.circle),
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

  Widget _buildAccountCard(BuildContext context, int index) {
    return Card(
      elevation: 10,
      child: SizedBox(
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
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.house,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                '0,00',
                style: Theme.of(context).textTheme.headline5,
              ),
              const Text('Housing'),
            ],
          ),
        ),
      ),
    );
  }
}
