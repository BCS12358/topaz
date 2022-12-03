// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/models/client/client.dart';
import 'package:topaz/screens/clients/clients_screen.dart';
import 'package:topaz/services/client_db_service.dart';
import 'package:topaz/utils/helpers.dart';

// ignore: must_be_immutable
class AddClientScreen extends StatefulWidget {
  static String routeName = '/add-client';
  Client? selectedClient;
  AddClientScreen({Key? key, this.selectedClient}) : super(key: key);

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  bool _isEditMode = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedClient != null) {
      _isEditMode = true;
      _nameController.text = widget.selectedClient!.name;
      _emailController.text = widget.selectedClient!.email;
      _phoneController.text = widget.selectedClient!.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clients'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: 500,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: const Icon(
                        Icons.person,
                        size: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        label: Text(
                          'Name',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the cellphone of the client';
                        }
                        return null;
                      },
                      onChanged: ((value) {
                        _nameController.text = value;
                        _nameController.selection = TextSelection.collapsed(
                            offset: _nameController.text.length);
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        label: Text(
                          'Phone',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the cellphone of the client';
                        }
                        return null;
                      },
                      onChanged: ((value) {
                        _phoneController.text = value;
                        _phoneController.selection = TextSelection.collapsed(
                            offset: _phoneController.text.length);
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        label: Text(
                          'Email',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : 'Enter email adress',
                      onChanged: ((value) {
                        _emailController.text = value;
                        _emailController.selection = TextSelection.collapsed(
                            offset: _emailController.text.length);
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ClientDBService(uid: user.uid).addClient(
                            client: Client(
                                name: _nameController.text,
                                phone: _phoneController.text,
                                email: _emailController.text),
                          );

                          Navigator.of(context)
                              .popAndPushNamed(ClientsScreen.routeName);

                          clearFields(context);

                          if (_isEditMode) {
                            showSnackBar(
                                context, 'Client updated successfully');
                          } else {
                            showSnackBar(
                                context, 'Client created successfully');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: _isEditMode
                          ? const Text('Update client')
                          : const Text('New client'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void clearFields(BuildContext context) {
    FocusScope.of(context).unfocus();
    _emailController.clear();
    _phoneController.clear();
    _nameController.clear();
  }
}
