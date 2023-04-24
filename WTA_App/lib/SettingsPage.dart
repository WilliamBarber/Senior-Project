import 'package:flutter/material.dart';
import 'AllPreviousReportsPage.dart';
import 'UserNamePage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      FractionallySizedBox(
        widthFactor: 0.85,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FractionallySizedBox(
              widthFactor: 0.7,
              child: ElevatedButton(
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
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(body: UserNamePage());
                    }),
                  );
                },
                child: Text('Add Username'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: ElevatedButton(
                onPressed: () {
                  print('About App Button Clicked');
                },
                child: Text('About This App'),
              ),
            ),
          ]),
        ),
      ),
    ]));
  }
}
