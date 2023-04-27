import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'HomePage.dart';
import 'NewReportPage.dart';
import 'SettingsPage.dart';
import 'MyAppState.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot){
          if (!snapshot.hasData){
            return SignInScreen(
                headerBuilder: (context, constraints, _) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                    style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                    'William Senior Project',
                    ),
                  );
                },
                providerConfigs: [
                  EmailProviderConfiguration(),
                ]
            );
          }
          else {
            var appState = context.watch<MyAppState>();
            appState.setUserName(snapshot.data?.uid);
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
                    } else {
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
        },
      );
  }
}
