import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DropDownButton.dart';
import 'MyAppState.dart';
import 'SeverityIndicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wta_app/OldReport.dart';
import 'NewReport.dart';

String title = "no title";
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
                      title = text;
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
                      description = text;
                    },
                    maxLines: null,
                  ),
                  Text('LOCATION HERE'),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      _getFromGallery();
                                    },
                                    child: Text('Pick From File'),
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
                    child: Text('Attach Photos'),
                  ),
                  ElevatedButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Submit Report?'),
                        content: const Text('Submit your trail issue report?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'No'),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context, 'Yes');
                              DateTime dateTime = DateTime.now();
                              String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                              String time = "${dateTime.hour}-${dateTime.minute}-${dateTime.second}";
                              if (imageFile != null) {
                                String imageURL = await NewReport.submitReport(
                                    title,
                                    description,
                                    severity,
                                    issue,
                                    imageFile,
                                    date,
                                    time,
                                    );
                                appState.addReport(OldReport(
                                    title,
                                    date,
                                    issue,
                                    description,
                                    severity,
                                    'test location',
                                    imageURL));
                              } else {
                                NewReport.submitNoImageReport(
                                    title, description, severity, issue, date, time);
                                appState.addReport(OldReport.noPhotos(
                                    title,
                                    date,
                                    issue,
                                    description,
                                    severity,
                                    'test location'));
                              }

                              appState.setPage(0);
                              // final snackBar = SnackBar(
                              //   content: Text('Report Successfully Submitted!'),
                              // );
                              //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                    child: Text('Submit Report'),
                  ),
                  ElevatedButton(
                    //TODO: Make the button or text red
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
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  _getFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
    }
    print('image selected from file');
  }

  _getFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
    print('image selected from camera');
  }
}
