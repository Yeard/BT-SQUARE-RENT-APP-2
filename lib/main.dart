import 'package:bt_square_rent_app/provider/sub_transaction_all_data.dart';
import 'package:bt_square_rent_app/screen/login_page.dart';
import 'package:bt_square_rent_app/screen/main_page.dart';
import 'package:bt_square_rent_app/screen/sub_transactions_screen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'provider/user_data.dart';
import 'provider/renters_all-data.dart';
import 'provider/detect_renters_IDandName.dart';

/*void main() {
  runApp(MyApp());
}*/
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RentersAllData(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetectRentersIdandName(),
        ),

        ChangeNotifierProvider(
          create: (context) => SubTransactionAlldata(),
        ),
        ChangeNotifierProvider(
          create: (context) => userData(),
        ),
        //
        //
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneTigerBd',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/SubTransactionScreen': (context) => SubTransactionScreen(),
        '/login': (context) => LoginPage(),
        '/MainPageScreen': (context) => MainPageScreen(),
      },
    );
  }
}
