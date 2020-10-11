import 'package:chat/enums/enums.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this._submitFn);

  final void Function(
          String email, String password, String username, AuthStatus authStatus)
      _submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthStatus authStatus = AuthStatus.LOGIN;
  var _formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';

  _submitForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    widget._submitFn(
        this._email, this._password, this._username, this.authStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 13,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (newValue) => this._email = newValue,
              ),
              if (authStatus == AuthStatus.SIGNUP)
                TextFormField(
                  key: ValueKey('username'),
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a valid username';
                    }
                    return null;
                  },
                  onSaved: (newValue) => this._username = newValue,
                ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value.isEmpty || value.length < 7) {
                    return 'Password must contain at least 6 characters';
                  }
                  return null;
                },
                onSaved: (newValue) => this._password = newValue,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: _submitForm,
                child: Text(
                  authStatus == AuthStatus.SIGNUP ? 'Signup' : 'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Theme.of(context).accentColor),
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (authStatus == AuthStatus.LOGIN) {
                    setState(() {
                      authStatus = AuthStatus.SIGNUP;
                    });
                  } else {
                    setState(() {
                      authStatus = AuthStatus.LOGIN;
                    });
                  }
                },
                child: Text(authStatus == AuthStatus.LOGIN
                    ? 'Create account'
                    : 'I already have an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
