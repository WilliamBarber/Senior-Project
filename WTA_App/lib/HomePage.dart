import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'OldReportPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var oldReports = appState.getAllReports();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Text(
          'Recent Reports:',
          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
      ),
      if (oldReports.isEmpty)
        Center(
          child: Card(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: FractionallySizedBox(
              widthFactor: 0.85,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                          TextSpan(
                              text: 'No reports submitted yet. Click the ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'New Report ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        ' button at the bottom of the screen to begin!'),
                              ]),
                          textAlign: TextAlign.center),
                    ]),
              ),
            ),
          ),
        )
      else
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: oldReports.length > 3 ? 3 : oldReports.length,
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
                              Text(
                                  'Title: ${appState.getReport(reportNumber).getTitle()}'),
                              Text(
                                  'Date: ${appState.getReport(reportNumber).getDate()}'),
                              Text(
                                  'Issue Category: ${appState.getReport(reportNumber).getCategory()}'),
                              ElevatedButton(
                                child: Text('View Report'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OldReportPage(
                                            report: appState
                                                .getReport(reportNumber))),
                                  );
                                },
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
          ),
        ),
    ]);
  }
}
