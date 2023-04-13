import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'OldReportPage.dart';

class HomePage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var oldReports = appState.getAllReports();
    return Center(
      child: FractionallySizedBox(//start new
        widthFactor: 0.85,
      child: ListView.builder(
      itemCount: oldReports.length > 3? 3 : oldReports.length,
      itemBuilder: (context, reportNumber) {
        return Card(
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
                    ElevatedButton(
                      child: Text('View Report'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OldReportPage(report: appState.getReport(reportNumber))),
                        );
                      },
                    ),
                  ]),
            ),
          ),
        );
      }
      ),
    ),//end new
      /*child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [//start old
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
      ]),*///end old
    );
  }
}