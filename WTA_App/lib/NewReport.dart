import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewReport{
    static void submitReport(String title, String description, double severity, String issue, File? imageFile) async {
    Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    var db = FirebaseFirestore.instance;
    // Create a new report with Description, Title, Severity, Issue type, and Images
    /*final firebaseImageFile = FirebaseStorage.instance.ref();
    final reportImage = firebaseImageFile
        .child("images/reports/reportimage.jpg")
        .putFile(imageFile!);
    print('Image File:');
    print('');
    print('');
    print(imageFile);
    print(reportImage);*/
    final report = <String, dynamic>{
      "title": title,
      "description": description,
      "severity": severity,
      "issue": issue,
      //"image": imageFile,
      //"image": reportImage,
    };

    // Add a new document with a generated ID
    db.collection("issue report").add(report).then(
            (DocumentReference doc) => print(
            'DocumentSnapshot added with ID: ${doc.id}'));

    await db.collection("issue report").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}