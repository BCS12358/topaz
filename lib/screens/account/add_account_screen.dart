import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/common/custom_color_collection.dart';
import 'package:topaz/models/common/custom_icon.dart';
import 'package:topaz/models/common/custom_icon_collection.dart';
import 'package:topaz/services/database_service.dart';
import 'package:topaz/utils/helpers.dart';

import '../../models/common/custom_color.dart';

class AddAccountScreen extends StatefulWidget {
  static String routeName = '/addAccount';

  const AddAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  CustomColor _selectedCustomColor = CustomColorCollection().colors.first;
  CustomIcon _selectedCustomIcon = CustomIconCollection().icons.first;
  final TextEditingController _accountTextController = TextEditingController();
  // ignore: unused_field
  String _accountName = '';

  @override
  void initState() {
    super.initState();
    _accountTextController.addListener(() {
      setState(() {
        _accountName = _accountTextController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Account'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedCustomColor.color),
                    child: Icon(
                      _selectedCustomIcon.iconData,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _accountTextController,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: (() {
                            _accountTextController.clear();
                          }),
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        itemCount: CustomIconCollection().icons.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCustomIcon =
                                    CustomIconCollection().icons[index];
                              });
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                CustomIconCollection().icons[index].iconData,
                              ),
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        itemCount: CustomColorCollection().colors.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: (() {
                              setState(() {
                                _selectedCustomColor =
                                    CustomColorCollection().colors[index];
                              });
                            }),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    CustomColorCollection().colors[index].color,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.indigo),
            onPressed: _accountName.length > 3
                ? () async {
                    final user = Provider.of<User?>(context, listen: false);
                    final newAccount = Account(
                        id: null,
                        name: _accountName,
                        icon: {
                          'icon': _selectedCustomIcon.id,
                          'color': _selectedCustomColor.id
                        });
                    try {
                      DatabaseService(uid: user!.uid)
                          .addAccount(account: newAccount);
                      showSnackBar(context, 'Account sucessfully created');
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                      showSnackBar(context, 'Ops! something went went wrong');
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
