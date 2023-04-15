import 'package:flutter/material.dart';

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
          print('Previous Reports Button Clicked');
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
