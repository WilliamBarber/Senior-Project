import 'package:flutter/material.dart';
import 'AllPreviousReportsPage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () {
          print('Contact Info Button Clicked');
        },
        child: Text('Enter Contact Information'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Scaffold(body: AllPreviousReportsPage());
            }),
          );
        },
        child: Text('View All Previous Reports'),
      ),
      ElevatedButton(
        onPressed: () {
          print('App Permissions Requested from Settings Menu');
        },
        child: Text('Request App Permissions'),
      ),
    ]));
  }
}
