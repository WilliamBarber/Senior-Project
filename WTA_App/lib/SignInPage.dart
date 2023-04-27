import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'MyAppState.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    String userName = 'NoUserNameCreated';
    return AlertDialog(
      title: const Text('Sign In'),
      content: const Text('Please enter or create your username'),
      actions: <Widget>[
        TextField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter Your Username',
          ),
          onChanged: (text) {
            userName = text;
          },
        ),
        TextButton(
          onPressed: () {
            appState.setUserName(userName);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Scaffold(body: HomePage());
              }),
            );
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
