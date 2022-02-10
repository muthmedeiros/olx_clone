import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'screens/base/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeParse();

  runApp(const MyApp());
}

Future<void> initializeParse() async {
  const appId = 'fd7iIkIuGY03BoPjB14FJQhvy0faVYNOqJ0n71fV';
  const parseServerUrl = 'https://parseapi.back4app.com/';
  const clientKey = 'CMJvS99xkhv5X5PKjoXV4ZsRktzuyWmsDCNBUvcI';

  await Parse().initialize(
    appId,
    parseServerUrl,
    clientKey: clientKey,
    autoSendSessionId: true,
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BaseScreen(),
    );
  }
}
