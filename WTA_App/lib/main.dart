import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Trail Issues Reporting App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = 0;
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = NewReportPage();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }
    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
              body: Row(
                children: [
                  SafeArea(
                      child: NavigationRail(
                        extended: constraints.maxWidth >= 600,
                        destinations: [
                          NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.add_circle),
                            label: Text('New Report'),
                          )
                        ],
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: (value) {
                          setState(() {
                            _selectedIndex = value;
                          });
                        },
                      ),
                  ),
                  Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: page,
                      ),
                  ),
                ],
              ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              tooltip: 'AddNewReport',
              icon: const Icon(Icons.add),
              label: const Text('New Report'),
              foregroundColor: Colors.white,
              backgroundColor: Colors.brown,
            ),
          );
        }
    );
  }
}

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

class NewReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter a Title for Your Report',
              ),
              onChanged: (text) {
                print('First text field: $text');
              },
            ),
          ]
      ),
    );
  }
}
