import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'OldReportPage.dart';

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
                    Text('Title: ${appState.getReport(0).getTitle()}'),
                    Text('Date: ${appState.getReport(0).getDate()}'),
                    Text('Issue Category: ${appState.getReport(0).getCategory()}'),
                    ElevatedButton(
                      child: Text('View Report'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OldReportPage(report: appState.getReport(0))),
                        );
                      },
                    ),
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
                    Text('Title: ${appState.getReport(1).getTitle()}'),
                    Text('Date: ${appState.getReport(1).getDate()}'),
                    Text('Issue Category: ${appState.getReport(1).getCategory()}'),
                    ElevatedButton(
                      child: Text('View Report'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OldReportPage(report: appState.getReport(1))),
                        );
                    },
                    ),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}