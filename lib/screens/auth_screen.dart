import 'package:chat/enums/enums.dart';
import 'package:chat/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

void _submit(
    String email, String password, String username, AuthStatus authStatus) {}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(12),
          child: AuthForm(_submit),
        ),
      ),
    );
  }
}
