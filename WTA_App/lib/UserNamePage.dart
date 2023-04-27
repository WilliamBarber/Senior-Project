import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';

class UserNamePage extends StatelessWidget {
  const UserNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    String tempUserName = '';
    var appState = context.watch<MyAppState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("All Previous Reports"),
          titleTextStyle:
              DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (appState.getUserName() == ('NoUserNameCreated'))
              Text('Current Username: No Username Created')
            else
              Text('Current Username: ${appState.getUserName()}'),
            FractionallySizedBox(
              widthFactor: 0.75,
              child: TextField(
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter a New Username',
                ),
                onChanged: (text) {
                  tempUserName = text;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  appState.setUserName(tempUserName);
                  appState.refreshOldReports();
                },
                child: Text('Submit New Username')),
          ]),
        ));
  }
}
