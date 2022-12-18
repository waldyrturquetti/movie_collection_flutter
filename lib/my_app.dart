import 'package:flutter/material.dart';
import 'package:flutter_review_app/constants/globals.dart';
import 'package:flutter_review_app/widgets/auth_check.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Globals.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const AuthCheck());
  }
}
