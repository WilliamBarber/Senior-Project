import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

const List<String> issuesList = <String>['Drainage', 'Fallen Tree', 'Trail Erosion', 'Overgrown Shrubbery', 'Damage to Man-made Structure', 'Other (Specify in Description)'];

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
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter a Title for Your Report',
              ),
              onChanged: (text) {
                print('First text field: $text');
              },
            ),
            DropDownButton(),
            SeverityIndicator(),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter a description for Your Report',
              ),
              onChanged: (text) {
                print('Description text field: $text');
              },
              maxLines: null,
            ),
          ]
      ),
    );
  }
}

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropDownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      hint: Text('Select an issue'),
      underline: Container(
        height: 2,
      ),
      onChanged: (String? value) {
        setState(() {
          dropDownValue = value!;
          print('Issues Drop-Down Menu Field: $value');
        });
      },
      items: issuesList.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    );
  }
}

class SeverityIndicator extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
        children: [
          RatingBar(
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            onRatingChanged: (value) => debugPrint('$value'),
            initialRating: 1,
            maxRating: 5,
          ),
          Text('Issue severity (5 stars is highest severity)'),
        ]
    );
  }

}