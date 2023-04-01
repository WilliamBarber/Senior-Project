import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';

class OldReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Placeholder'),
          ElevatedButton(
              onPressed: () {
                print('Go Back Pressed');
              },
              child: Text('Go Back')
          ),
        ]));
  }
}