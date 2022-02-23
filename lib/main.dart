import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'screens/base/base_screen.dart';
import 'stores/page_store.dart';
import 'stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeParse();

  setUpLocators();

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

void setUpLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.purple,
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.orange,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
            onSurface: Colors.orange.withAlpha(120),
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          disabledColor: Colors.orange.withAlpha(120),
        ),
      ),
      home: const BaseScreen(),
    );
  }
}
