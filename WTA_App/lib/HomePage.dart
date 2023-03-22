import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';

class HomePage extends StatelessWidget {
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
                    Text('Previous Report Title'),
                    Text('Previous Report Date'),
                    Text('Previous Report Category'),
                  ]),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Previous Report Title'),
                    Text('Previous Report Date'),
                    Text('Previous Report Category'),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}