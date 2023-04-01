import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';

class OldReportPage extends StatelessWidget {
  const OldReportPage({super.key, required this.reportNumber});

  final int reportNumber;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: Center(
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
                        Text('Title: ${appState.getReport(reportNumber).getTitle()}'),
                        Text('Date: ${appState.getReport(reportNumber).getDate()}'),
                        Text('Issue Category: ${appState.getReport(reportNumber).getCategory()}'),
                        Text('Severity: ${appState.getReport(reportNumber).getSeverity().toInt()} / 5'),
                        Text('Description: ${appState.getReport(reportNumber).getDescription()}'),
                        Text('Location: ${appState.getReport(reportNumber).getLocation()}'),
                        Text('Photos: ${appState.getReport(reportNumber).getPhotos()}'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Return to home page'),
                        ),
                      ])),
            ),
          ),
        ]),
      ),
    );
  }
}
