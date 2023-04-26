import 'package:flutter/material.dart';

class AboutThisAppPage extends StatelessWidget {
  const AboutThisAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About This App"),
          titleTextStyle:
          DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Version Beta-1'),
            Text('Created using Flutter'),
            Text('William Barber'),
          ]),
        ));
  }
}
