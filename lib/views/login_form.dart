import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../colors.dart' as colors;

class LoginForm extends StatefulWidget {
  // was autogenerated, might be needed later
  // const LoginForm({
  //   Key key,
  // }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email, _password;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 280,
            height: 56,
            child: TextFormField(
              style: TextStyle(
                color: colors.cardColor,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: colors.cardColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 2,
                  ),
                ),
              ),
              // TODO: add validator for email
              onSaved: (input) => _email = input,
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
          Container(
            width: 280,
            height: 56,
            child: TextFormField(
              style: TextStyle(
                color: colors.cardColor,
                fontSize: 16,
              ),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: colors.cardColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 2,
                  ),
                ),
              ),
              // TODO: add validator for password
              onSaved: (input) => _password = input,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(),
                  ),
                  // TODO: Add functionality to clear input fields
                  onPressed: () {},
                ),
                margin: EdgeInsets.only(
                  right: 16,
                ),
              ),
              Container(
                child: RaisedButton(
                  color: colors.cardColor,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: colors.backgroundColor,
                    ),
                  ),
                  onPressed: signIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// credentials validation via firebase_auth
  void signIn() async {
    // TODO: validate user
    final loginFormState = _loginFormKey.currentState;
    // https://pub.dev/packages/firebase_auth
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (loginFormState.validate()) {
      loginFormState.save();
      try {
        FirebaseUser userData = (await _auth.signInWithEmailAndPassword(email: _email, password: _password)).user;
        // * WARNING: `unawaited` might cause a problem
        unawaited(Navigator.pushNamed(context, '/homeTest'));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
