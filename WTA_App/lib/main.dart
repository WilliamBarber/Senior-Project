import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomePage.dart';
import 'MyAppState.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

const List<String> issuesList = <String>[
  'Drainage',
  'Fallen Tree',
  'Trail Erosion',
  'Overgrown Shrubbery',
  'Damage to Man-made Structure',
  'Other (Specify in Description)'
];

Future<void> main() async {
  runApp(const MyApp());
  //Start Firebase testing
  Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var db = FirebaseFirestore.instance;
  // Create a new user with a first and last name
  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };

// Add a new document with a generated ID
  db.collection("contacts").add(user).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));

  await db.collection("contacts").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
//End Firebase testing

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
      case 2:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
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
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
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
    });
  }
}

class NewReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      textCapitalization: TextCapitalization.words,
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
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Enter a Description for Your Report',
                      ),
                      onChanged: (text) {
                        print('Description text field: $text');
                      },
                      maxLines: null,
                    ),
                    Text('LOCATION HERE'),
                    Text('PHOTOS HERE'),
                    ElevatedButton(
                      onPressed: () {
                        print('Submit Report Clicked');
                      },
                      child: Text('Submit Report'),
                    ),
                    ElevatedButton(
                      //TODO: Make the button or text red
                        onPressed: () {
                          print('Cancel Report Clicked');
                          //TODO: Make the button send the user back to the homepage
                        },
                        child: Text('Cancel Report'),
                    ),
                  ],
                ),
            ),
          ),
        ),
      ]),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
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
      items: issuesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SeverityIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RatingBar(
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
        onRatingChanged: (value) => debugPrint('$value'),
        initialRating: 1,
        maxRating: 5,
      ),
      Text('Issue severity (5 stars is highest severity)'),
    ]);
  }
}
