import 'package:flutter/material.dart';
import 'package:topaz/models/common/custom_color_collection.dart';
import 'package:topaz/models/common/custom_icon.dart';
import 'package:topaz/models/common/custom_icon_collection.dart';

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
      _accountName = _accountTextController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Account'),
        actions: [
          TextButton(
              onPressed: (() {}),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _selectedCustomColor.color),
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
            const Padding(
              padding: EdgeInsets.all(10),
              child: Divider(
                height: 10,
                thickness: 5,
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final ci in CustomIconCollection().icons)
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        _selectedCustomIcon = ci;
                      });
                    }),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child: Icon(
                        ci.iconData,
                      ),
                    ),
                  )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Divider(
                height: 10,
                thickness: 5,
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final cc in CustomColorCollection().colors)
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        _selectedCustomColor = cc;
                      });
                    }),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cc.color,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
