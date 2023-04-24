import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

class NewReport {
  static Future<String> submitReport(
      String userName,
      String title,
      String description,
      double severity,
      String issue,
      File? imageFile,
      double latitude,
      double longitude,
      String date,
      String time) async {

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
    await storageRef.child("$date-$time-$title").putFile(imageFile!);
    final imageURL =
      await storageRef.child("$date-$time-$title").getDownloadURL();

    //End Image Submission

    db.collection("issue report").doc("$date-$time-$title").set({
      "title": title,
      "description": description,
      "severity": severity,
      "issue": issue,
      "image": imageURL,
      "latitude": latitude,
      "longitude": longitude,
      "date": date
    });

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
    return imageURL;
  }

  static Future<String> submitNoLocationReport(
      String userName,
      String title,
      String description,
      double severity,
      String issue,
      File? imageFile,
      String date,
      String time) async {
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
    await storageRef.child("$date-$time-$title").putFile(imageFile!);
    final imageURL =
        await storageRef.child("$date-$time-$title").getDownloadURL();

    //End Image Submission

    db.collection("issue report").doc("$date-$time-$title").set({
      "title": title,
      "description": description,
      "severity": severity,
      "issue": issue,
      "image": imageURL,
      "latitude": "No Location",
      "longitude": "No location",
      "date": date
    });

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
    return imageURL;
  }

  static submitNoImageReport(String userName, String title, String description, double severity,
      String issue, double latitude,
      double longitude, String date, String time) async {
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

    db.collection("issue report").doc("$date-$time-$title").set({
      "title": title,
      "description": description,
      "severity": severity,
      "issue": issue,
      "image": 'No Image',
      "latitude": latitude,
      "longitude": longitude,
      "date": date,
    });

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  static submitNoImageNoLocationReport(
      String userName,
      String title,
      String description,
      double severity,
      String issue,
      String date,
      String time) async {
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

    db.collection("issue report").doc("$date-$time-$title").set({
      "title": title,
      "description": description,
      "severity": severity,
      "issue": issue,
      "image": "No Image",
      "latitude": "No Location",
      "longitude": "No Location",
      "date": date
    });

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
