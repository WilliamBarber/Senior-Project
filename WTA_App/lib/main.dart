import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'MyApp.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
