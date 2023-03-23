import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DropDownButton.dart';
import 'MyAppState.dart';
import 'SeverityIndicator.dart';

class NewReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    textCapitalization: TextCapitalization.words,
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
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Enter a Description for Your Report',
                    ),
                    onChanged: (text) {
                      print('Description text field: $text');
                    },
                    maxLines: null,
                  ),
                  Text('LOCATION HERE'),
                  Text('PHOTOS HERE'),
                  ElevatedButton(
                    onPressed: () {
                      print('Submit Report Clicked');
                    },
                    child: Text('Submit Report'),
                  ),
                  ElevatedButton(
                    //TODO: Make the button or text red
                    onPressed: () {
                      print('Cancel Report Clicked');
                      //TODO: Make the button send the user back to the homepage
                    },
                    child: Text('Cancel Report'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}