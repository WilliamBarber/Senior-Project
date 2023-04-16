import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';
import 'OldReportPage.dart';

class AllPreviousReportsPage extends StatelessWidget {
  const AllPreviousReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var oldReports = appState.getAllReports();
    return Scaffold(
        /*floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'PreviousPage',
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous Page'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.brown,
        ),*/
        bottomSheet: Container(
          color: Colors.green,
          height: 78,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Return to settings page'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: oldReports.isEmpty
            ? Center(
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Recent Reports',
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 2.0),
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
                                  Text.rich(
                                      TextSpan(
                                          text:
                                              'No reports submitted yet. Return to the home screen and click the ',
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'New Report ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    'button at the bottom of the screen to begin!'),
                                          ]),
                                      textAlign: TextAlign.center),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 50, bottom: 85),
                      shrinkWrap: true,
                      itemCount: oldReports.length + 1,
                      itemBuilder: (context, reportNumber) {
                        if (reportNumber == 0) {
                          return Text(
                            'All Previous Reports',
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
                                          'Title: ${appState.getReport(reportNumber - 1).getTitle()}'),
                                      Text(
                                          'Date: ${appState.getReport(reportNumber - 1).getDate()}'),
                                      Text(
                                          'Issue Category: ${appState.getReport(reportNumber - 1).getCategory()}'),
                                      ElevatedButton(
                                        child: Text('View Report'),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OldReportPage(
                                                        report: appState
                                                            .getReport(
                                                                reportNumber -
                                                                    1))),
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
              ));
  }
}
