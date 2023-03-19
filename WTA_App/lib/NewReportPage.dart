import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main-Gimli-Linux.dart';

class NewReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter a Title for Your Report',
              ),
              onChanged: (text) {
                print('First text field: $text');
              },
            ),
            DropDownButton(),
            SeverityIndicator(),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter a Description for Your Report',
              ),
              onChanged: (text) {
                print('Description text field: $text');
              },
              maxLines: null,
            ),
          ]
      ),
    );
  }
}