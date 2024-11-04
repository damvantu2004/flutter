import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class BankAPIServer {
  static BaseAPIServer api = BaseAPIServer();
  String url() => 'bank';

  Future<void> addBank(Map<String, dynamic> data) async {
    await api.set(id: data['id'].toString(), url: url(), data: data);
  }
}
