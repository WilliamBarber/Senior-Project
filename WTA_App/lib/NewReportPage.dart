import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DropDownButton.dart';
import 'MyAppState.dart';
import 'SeverityIndicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wta_app/OldReport.dart';
import 'NewReport.dart';
import 'LocationPage.dart';

String title = "no title";
String trailhead = 'no trailhead';
String description = 'no description';

class NewReportPage extends StatefulWidget {
  @override
  State<NewReportPage> createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          FractionallySizedBox(
            widthFactor: 0.85,
            child: Text(
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
                'New Report Submission'),
          ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(fontSizeFactor: 1.7),
                              'Title:'),
                          TextField(
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Enter a Title for Your Report',
                            ),
                            onChanged: (text) {
                              title = text;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          ),
                          Text(
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(fontSizeFactor: 1.7),
                              'Details:'),
                          TextField(
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Enter the Trailhead Name',
                            ),
                            onChanged: (text) {
                              trailhead = text;
                            },
                          ),
                        ],
                      ),
                      DropDownButton(),
                      SeverityIndicator(),
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Enter a Description for Your Report',
                        ),
                        onChanged: (text) {
                          description = text;
                        },
                        maxLines: null,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.47,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Scaffold(body: LocationPage());
                              }),
                            );
                          },
                          child: Text('Attach Location'),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.47,
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 78,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            _getFromGallery();
                                          },
                                          child: Text('Pick From File'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _getFromCamera();
                                          },
                                          child: Text('Take a Photo'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: imageFile == null
                              ? Text('Attach Image')
                              : Text('Replace Image'),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.47,
                        child: ElevatedButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Submit Report?'),
                              content:
                                  const Text('Submit your trail issue report?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'No'),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context, 'Yes');
                                    appState.setPage(0);
                                    DateTime dateTime = DateTime.now();
                                    String date =
                                        "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                    String time =
                                        "${dateTime.hour}-${dateTime.minute}-${dateTime.second}";
                                    if (imageFile != null &&
                                        appState.getLatitude() > -1000) {
                                      String imageURL =
                                          await NewReport.submitReport(
                                        appState.getUserName(),
                                        title,
                                        trailhead,
                                        description,
                                        severity,
                                        issue,
                                        imageFile,
                                        appState.getLatitude(),
                                        appState.getLongitude(),
                                        date,
                                        time,
                                      );
                                      appState.addReport(OldReport(
                                          title,
                                          trailhead,
                                          date,
                                          issue,
                                          description,
                                          severity,
                                          appState.getLatitude(),
                                          appState.getLongitude(),
                                          imageURL));
                                    } else if (imageFile == null &&
                                        appState.getLatitude() > -1000) {
                                      NewReport.submitNoImageReport(
                                          appState.getUserName(),
                                          title,
                                          trailhead,
                                          description,
                                          severity,
                                          issue,
                                          appState.getLatitude(),
                                          appState.getLongitude(),
                                          date,
                                          time);
                                      appState.addReport(OldReport.noImage(
                                          title,
                                          trailhead,
                                          date,
                                          issue,
                                          description,
                                          severity,
                                          appState.getLatitude(),
                                          appState.getLongitude()));
                                    } else if (imageFile != null &&
                                        appState.getLatitude() == -1000) {
                                      String imageURL = await NewReport
                                          .submitNoLocationReport(
                                              appState.getUserName(),
                                              title,
                                              trailhead,
                                              description,
                                              severity,
                                              issue,
                                              imageFile,
                                              date,
                                              time);
                                      appState.addReport(OldReport.noLocation(
                                          title,
                                          trailhead,
                                          date,
                                          issue,
                                          description,
                                          severity,
                                          imageURL));
                                    } else {
                                      NewReport.submitNoImageNoLocationReport(
                                          appState.getUserName(),
                                          title,
                                          trailhead,
                                          description,
                                          severity,
                                          issue,
                                          date,
                                          time);
                                      appState.addReport(
                                          OldReport.noImageNoLocation(
                                              title,
                                              trailhead,
                                              date,
                                              issue,
                                              description,
                                              severity));
                                    }
                                    title = "no title";
                                    trailhead = 'no trailhead';
                                    description = "no description";
                                    appState.setLocationUsed(true);
                                    severity = 1;
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          ),
                          child: Text('Submit Report'),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.47,
                        child: ElevatedButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Cancel Report?'),
                              content: const Text(
                                  'Cancel report and return to the home screen?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'No'),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Yes');
                                    appState.setPage(0);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          ),
                          child: Text('Cancel Report'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      imageFile = File(image.path);
    }
    print('image selected from file');
    Navigator.pop(context);
  }

  _getFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
    print('image selected from camera');
    Navigator.pop(context);
  }
}
