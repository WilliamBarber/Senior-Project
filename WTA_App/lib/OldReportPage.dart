import 'package:flutter/material.dart';
import 'OldReport.dart';
import 'PhotoViewer.dart';

class OldReportPage extends StatelessWidget {
  const OldReportPage({super.key, required this.report});

  final OldReport report;

  @override
  Widget build(BuildContext context) {
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
                        Text('Title: ${report.getTitle()}'),
                        Text('Date: ${report.getDate()}'),
                        Text('Issue Category: ${report.getCategory()}'),
                        Text('Severity: ${report.getSeverity().toInt()} / 5'),
                        Text('Description: ${report.getDescription()}'),
                        Text('Location: ${report.getLocation()}'),
                        //Text('Photos: ${report.getPhotos()}'),
                        if (report.getPhotos() != 'no photos')
                          ElevatedButton(
                            child: Text('View Photos'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhotoViewer(
                                        photoURL: report.getPhotos())),
                              );
                            },
                          ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Return to previous page'),
                        ),
                      ])),
            ),
          ),
        ]),
      ),
    );
  }
}
