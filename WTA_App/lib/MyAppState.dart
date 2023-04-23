import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'OldReport.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class MyAppState extends ChangeNotifier {
  var current = 0;
  var oldReports = <OldReport>[];
  var selectedIndex = 0;
  var appInitialized = false;

  void setPage(int page) {
    selectedIndex = page;
    notifyListeners();
  }

  int getPage() {
    return selectedIndex;
  }

  void addReport(oldReport) {
    oldReports.insert(0, oldReport);
    notifyListeners();
  }

  OldReport getReport(int reportNumber) {
    if (oldReports.length > reportNumber) {
      return oldReports[reportNumber];
    }
    return OldReport.empty();
  }

  List<OldReport> getAllReports() {
    return oldReports;
  }

  initializeOldReports(BuildContext context) async {
    if (!appInitialized) {
      appInitialized = true;

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      var db = FirebaseFirestore.instance;

      await db.collection("issue report").get().then((event) {
        for (var doc in event.docs) {
          addReport(OldReport(
              doc.get("title"),
              doc.get("date"),
              doc.get("issue"),
              doc.get("description"),
              doc.get("severity"),
              'test location',
              doc.get("image"))
          );
        }
      });
    }
    notifyListeners();
  }
}
