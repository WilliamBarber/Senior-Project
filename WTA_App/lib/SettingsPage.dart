import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main-Gimli-Linux.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Contact Information',
                ),
                onChanged: (text) {
                  print('Contact Info: $text');
                },
              ),
            ]
        )

    );
  }
}