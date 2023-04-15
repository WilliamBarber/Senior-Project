import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'NewReportPage.dart';
import 'SettingsPage.dart';
import 'MyAppState.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var selectedIndex = appState.getPage();
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = NewReportPage();
        break;
      case 2:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle),
              label: 'New Report',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            appState.setPage(index);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            appState.setPage(1);
          },
          tooltip: 'AddNewReport',
          icon: const Icon(Icons.add),
          label: const Text('New Report'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.brown,
        ),
      );
    });
  }
}
