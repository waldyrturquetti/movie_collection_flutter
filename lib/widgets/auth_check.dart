import 'package:flutter/material.dart';
import 'package:flutter_review_app/pages/home_page.dart';
import 'package:flutter_review_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_review_app/pages/login_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);

    if (authService.isLoading) {
      return loading();
    } else if (authService.user == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
