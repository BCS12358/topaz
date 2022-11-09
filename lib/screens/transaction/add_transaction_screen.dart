import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/account/account.dart';
import 'package:topaz/models/transaction/transaction.dart';
import 'package:topaz/services/database_service.dart';

class AddTransactionScreen extends StatefulWidget {
  static String routeName = '/add-transaction';

  final Account selectedAccount;

  // ignore: use_key_in_widget_constructors
  const AddTransactionScreen({required this.selectedAccount});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';
  double _price = 0.0;
  int _qtd = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        'Name',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for the transaction';
                      }
                      return null;
                    },
                    onChanged: ((value) => setState(() => _title = value)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        'Price',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price for the transaction';
                      }
                      return null;
                    },
                    onChanged: ((value) =>
                        setState(() => _price = double.parse(value))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        'Amount',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount for the transaction';
                      }
                      return null;
                    },
                    onChanged: ((value) =>
                        setState(() => _qtd = int.parse(value))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Card(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        tileColor: Theme.of(context).scaffoldBackgroundColor,
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 365)));

                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        leading: Text(
                          'Date',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(DateFormat.yMMMEd()
                                .format(_selectedDate)
                                .toString()),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      tileColor: Theme.of(context).scaffoldBackgroundColor,
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());

                        if (pickedTime != null) {
                          setState(() {
                            _selectedTime = pickedTime;
                          });
                        }
                      },
                      leading: Text(
                        'Time',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.watch_later_outlined,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_selectedTime.format(context).toString()),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_formKey.currentState!.validate()) {
                                  final user = Provider.of<User?>(context,
                                      listen: false);
                                  final newTx =
                                      _createNewTransaction(incoming: true);
                                  try {
                                    DatabaseService(uid: user!.uid)
                                        .addTransaction(transaction: newTx);
                                    Navigator.pop(context);
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                              child: const Text('Incoming'),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  padding: EdgeInsets.zero),
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_formKey.currentState!.validate()) {
                                  final user = Provider.of<User?>(context,
                                      listen: false);

                                  final newTx =
                                      _createNewTransaction(incoming: false);
                                  try {
                                    DatabaseService(uid: user!.uid)
                                        .addTransaction(transaction: newTx);
                                    Navigator.pop(context);
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                              child: const Text('Outgoing'),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Transaction _createNewTransaction({required bool incoming}) {
    return Transaction(
      title: _title,
      price: incoming ? _price : (_price * -1),
      qtd: _qtd,
      account: widget.selectedAccount.toJson(),
      incoming: incoming,
      txDate: _selectedDate.millisecondsSinceEpoch,
      txTime: {'hour': _selectedTime.hour, 'minute': _selectedTime.minute},
    );
  }
}
