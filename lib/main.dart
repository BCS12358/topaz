import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topaz/config/custom_theme.dart';
import 'package:topaz/screens/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Topaz',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.blueGrey.shade800),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => CustomTheme()),
          )
        ],
        child: const Wrapper(),
      ),
    );
  }
}
