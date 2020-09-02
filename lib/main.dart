import 'package:flutter/material.dart';
import 'package:pharm_pfe/authentification/login_page.dart';
import 'package:pharm_pfe/style/style.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 24,
                fontFamily: 'bls',
                color: Style.primaryColor), //Large
            bodyText2: TextStyle(
                fontSize: 18,
                fontFamily: 'bls',
                color: Style.primaryColor), //medium
            caption: TextStyle(
                fontSize: 14,
                fontFamily: 'bls',
                color: Style.secondaryColor), //small
          ),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Style.darkBackgroundColor))),
    );
  }
}
