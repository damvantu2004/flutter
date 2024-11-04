import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseAPIServer {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  CollectionReference getCollection(String urlJson) {
    List<String> url = formatUrl(urlJson).split('\\');
    CollectionReference collection = firestore.collection(url[0]);
    for (int i = 1; i < url.length; i + 2) {
      collection = collection.doc(url[i]).collection(url[i + 1]);
    }
    return collection;
  }

  DocumentReference getDocument(String urlJson) {
    List<String> url = formatUrl(urlJson).split('\\');
    DocumentReference documment = firestore.collection(url[0]).doc(url[1]);
    for (int i = 2; i < url.length; i + 2) {
      documment = documment.collection(url[i]).doc(url[i + 1]);
    }
    return documment;
  }

  Future<String> add({required String url, required Map<String, dynamic> data}) {
    data["created_time"] = Timestamp.now();
    CollectionReference collectionReference = getCollection(url);
    return collectionReference.add(data).then((value) {
      // Fluttertoast.showToast(msg: "Add successfull");
      return value.id;
    }).catchError((error) {
      // Fluttertoast.showToast(msg: "Failed to add: $error");
      return "";
    });
  }

  Future<void> set({required String url, required String id, required Map<String, dynamic> data}) async {
    data["created_time"] = Timestamp.now();
    CollectionReference collectionReference = getCollection(url);
    return await collectionReference.doc(id).set(data).then((value) {
      // Fluttertoast.showToast(msg: "Add successfull");
    }).catchError((error) {
      // Fluttertoast.showToast(msg: "Failed to add: $error");
    });
  }

  Future<void> update({required String url, required String id, required Map<String, dynamic> data}) async {
    data["update_time"] = Timestamp.now();
    CollectionReference collectionReference = getCollection(url);
    return await collectionReference.doc(id).update(data).then((value) {
      // Fluttertoast.showToast(msg: "Update successfull");
    }).catchError((error) {
      // Fluttertoast.showToast(msg: "Failed to update: $error");
    });
  }

  Future<void> delete({required String url, required String id}) async {
    CollectionReference collectionReference = getCollection(url);
    await collectionReference.doc(id).delete().then((value) => print("Deleted Successful")).catchError((error) => print("Failed to delete: $error"));
  }

  Future<void> getList({required String url}) async {}

  String formatUrl(String url) {
    url = url.trim();
    url = url.replaceAll(' ', '');
    while (url[0] == '/') url = url.substring(1, url.length);
    while (url[url.length - 1] == '/') url = url.substring(0, url.length - 1);
    return url;
  }

  Future<List<String>> uploadFilesList(String url, List<String> files) async {
    List<String> re = [];
    for (int i = 0; i < files.length; i++) {
      File file = File(files[i]);
      String filename = getFileName(files[i]);
      try {
        TaskSnapshot taskSnapshot = await _firebaseStorage.ref('$url/$filename').putFile(file).whenComplete(() => print(""));
        String st = await taskSnapshot.ref.getDownloadURL();
        re.add(st.toString());
      } on FirebaseException catch (e) {
        print("Error upload image:" + e.toString());
      }
    }
    return re;
  }

  Future<String> uploadFiles(String url, String files) async {
    String re = "";
    File file = File(files);
    String filename = getFileName(files);
    try {
      TaskSnapshot taskSnapshot = await _firebaseStorage.ref('$url/$filename').putFile(file).whenComplete(() => print(""));
      String st = await taskSnapshot.ref.getDownloadURL();
      re = st.toString();
    } on FirebaseException catch (e) {
      print("Error upload image:" + e.toString());
    }
    return re;
  }

  String getRandomString(int length) {
    var chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  String getFileName(String filePath) {
    String fileName = filePath;
    if (fileName[0] == "/") fileName = fileName.substring(1);
    while (fileName.contains("/")) {
      fileName = fileName.substring(fileName.indexOf("/") + 1);
    }
    return fileName;
  }
}
