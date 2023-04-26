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
    if (appState.getUserName() == "NoUserNameCreated"){
      String userName = 'NoUserNameCreated';
      return AlertDialog(
        title: const Text('Sign In'),
        content: const Text(
            'Please enter or create your username'),
        actions: <Widget>[
          TextField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Your Username',
            ),
            onChanged: (text) {
              userName = text;
            },
          ),
          TextButton(
            onPressed: () {
              appState.setUserName(userName);
            },
            child: const Text('Submit'),
          ),
        ],
      );
    }
    else {
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primaryContainer,
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
              if ((index == 0 || index == 2) && selectedIndex == 1) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: const Text('Cancel Report?'),
                        content: const Text(
                            'Cancel report and go to the selected screen?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'No'),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Yes');
                              appState.setPage(index);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                );
              }
              else {
                appState.setPage(index);
              }
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
}
