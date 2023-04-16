import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'OldReportPage.dart';

//TODO: warning for going home from new report page
//TODO: actually intelligible report ids
//TODO: mapping integration
//TODO: required/optional fields
//TODO: authentication
//TODO: unique image URLs
//TODO: generate old reports list from firebase instead of only from locally stored files from the current session

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var oldReports = appState.getAllReports();
    if (oldReports.isEmpty) {
      return Center(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    'Recent Reports',
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 2.0),
                  );
                } else {
                  return Card(
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
                                      text:
                                          'No reports submitted yet. Click the ',
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'New Report ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                'button at the bottom of the screen to begin!'),
                                      ]),
                                  textAlign: TextAlign.center),
                            ]),
                      ),
                    ),
                  );
                }
              }),
        ),
      );
    } else {
      return Center(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: oldReports.length > 3 ? 4 : oldReports.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    'Recent Reports',
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 2.0),
                  );
                } else {
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
                                  'Title: ${appState.getReport(index - 1).getTitle()}'),
                              Text(
                                  'Date: ${appState.getReport(index - 1).getDate()}'),
                              Text(
                                  'Issue Category: ${appState.getReport(index - 1).getCategory()}'),
                              ElevatedButton(
                                child: Text('View Report'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OldReportPage(
                                            report:
                                                appState.getReport(index - 1))),
                                  );
                                },
                              ),
                            ]),
                      ),
                    ),
                  );
                }
              }),
        ),
      );
    }
  }
}
