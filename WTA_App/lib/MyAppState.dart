import 'package:flutter/cupertino.dart';
import 'OldReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAppState extends ChangeNotifier {
  String? userName = 'NoUserNameCreated';
  var oldReports = <OldReport>[];
  var selectedIndex = 0;
  var appInitialized = false;
  bool locationUsed = false;
  double? latitude = -1000;
  double? longitude = -1000;

  void setPage(int page) {
    selectedIndex = page;
    notifyListeners();
  }

  void setUserName(String? userName) {
    this.userName = userName;
    notifyListeners();
  }

  String? getUserName() {
    return userName;
  }

  int getPage() {
    return selectedIndex;
  }

  void setLocation(double? latitude, double? longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
    locationUsed = false;
  }

  double getLatitude() {
    if (locationUsed) {
      latitude = -1000;
    }
    return latitude!;
  }

  double getLongitude() {
    if (locationUsed) {
      longitude = -1000;
    }
    return longitude!;
  }

  void setLocationUsed(bool used) {
    locationUsed = used;
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

  void refreshOldReports() async {
    oldReports.clear();

    var db = FirebaseFirestore.instance;

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print(doc.get("userName") + "  " + userName);
        if (doc.get("userName") == userName) {
          if (!(doc.get("longitude").toString() == ("No Location") ||
              doc.get("image").toString() == ("No Image"))) {
            addReport(OldReport(
                doc.get("title"),
                doc.get("trailhead"),
                doc.get("date"),
                doc.get("issue"),
                doc.get("description"),
                doc.get("severity"),
                doc.get("latitude"),
                doc.get("longitude"),
                doc.get("image")));
          } else if (doc.get("longitude").toString() == ("No Location") &&
              !(doc.get("image").toString() == ("No Image"))) {
            addReport(OldReport.noLocation(
                doc.get("title"),
                doc.get("trailhead"),
                doc.get("date"),
                doc.get("issue"),
                doc.get("description"),
                doc.get("severity"),
                doc.get("image")));
          } else if (doc.get("longitude").toString() == ("No Location") &&
              !(doc.get("image").toString() == ("No Image"))) {
            addReport(OldReport.noPhotos(
                doc.get("title"),
                doc.get("trailhead"),
                doc.get("date"),
                doc.get("issue"),
                doc.get("description"),
                doc.get("severity"),
                doc.get("latitude"),
                doc.get("longitude")));
          } else {
            addReport(
              OldReport.noPhotosNoLocation(
                  doc.get("title"),
                  doc.get("trailhead"),
                  doc.get("date"),
                  doc.get("issue"),
                  doc.get("description"),
                  doc.get("severity")),
            );
          }
        }
      }
    });
    notifyListeners();
  }

  void initializeOldReports(BuildContext context) async {
    if (!appInitialized) {
      appInitialized = true;
      refreshOldReports();
    }
    notifyListeners();
  }
}
