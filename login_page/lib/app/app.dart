import 'package:flutter/material.dart';
import 'package:sabak_8_login_page/home/login_page.dart';
import 'package:sabak_8_login_page/theme/constat.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kPrimaryColor,
              fontFamily: 'Montserrat',
            ),
      ),
      home: LoginPage(),
    );
  }
}
