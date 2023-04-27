import 'package:flutter/material.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({super.key, required this.photoURL});

  final String photoURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                        Image.network(photoURL),
                        Text('Image may take a moment to load.'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Return to previous page'),
                        ),
                      ])),
            ),
          ),
        ]),
      ),
    );
  }
}
