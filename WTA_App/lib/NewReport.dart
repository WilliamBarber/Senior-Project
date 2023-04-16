import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

class NewReport {
  static Future<String> submitReport(String title, String description,
      double severity, String issue, File? imageFile, String date) async {
    print('');
    print('');
    print('');
    print("attempting submission");
    print('');
    print('');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    var db = FirebaseFirestore.instance;

    //Start Image Submission
    await FirebaseAuth.instance.signInAnonymously();
    final storageRef = FirebaseStorage.instance.ref();
    await storageRef.child("Image File").putFile(imageFile!);
    final imageURL = await storageRef.child("Image File").getDownloadURL();

    //End Image Submission

    // Add a new document with a specified ID
    db.collection("issue report").doc("test_id").set({"title": title,
      "description": description,
      "severity": severity,
      "issue": issue,
      "image": imageURL,
      "date": date});

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
    return imageURL;
  }

  static submitNoImageReport(
      String title, String description, double severity, String issue, String date) async {
    print('');
    print('');
    print('');
    print("attempting submission");
    print('');
    print('');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    var db = FirebaseFirestore.instance;

    // Create a new report with Description, Title, Severity, Issue type, and Image URL
    final report = <String, dynamic>{
      "title": title,
      "description": description,
      "severity": severity,
      "issue": issue,
      "image": 'No Image',
      "date": date,
    };

    // Add a new document with a generated ID
    db.collection("issue report").add(report).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
