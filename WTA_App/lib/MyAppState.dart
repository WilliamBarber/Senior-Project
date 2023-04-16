import 'package:flutter/cupertino.dart';
import 'OldReport.dart';

class MyAppState extends ChangeNotifier {
  var current = 0;
  var oldReports = <OldReport>[];
  var selectedIndex = 0;

  void setPage(int page) {
    selectedIndex = page;
    notifyListeners();
  }

  int getPage() {
    return selectedIndex;
  }

  void addReport(oldReport) {
    oldReports.insert(0, oldReport);
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
}
