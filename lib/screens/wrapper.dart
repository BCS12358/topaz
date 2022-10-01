import 'package:flutter/material.dart';
import 'package:topaz/config/custom_theme.dart';
import 'package:topaz/screens/account/add_account_screen.dart';
import 'package:topaz/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Provider.of<CustomTheme>(context);

    return MaterialApp(
      title: 'Topaz',
      initialRoute: '/',
      routes: {
        HomeScreen.routeName: ((context) => const HomeScreen()),
        AddAccountScreen.routeName: ((context) => const AddAccountScreen()),
      },
      home: const HomeScreen(),
      theme: customTheme.darkTheme,
      darkTheme: customTheme.darkTheme,
      themeMode: customTheme.currentTheme(),
    );
  }
}
