import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main-Gimli-Linux.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Homepage Placeholder'),
          ]
      ),
    );
  }
}