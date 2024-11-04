import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class SearchAPIServer {
  String searchURL(String userId) => "/users/$userId/search";
  static BaseAPIServer api = BaseAPIServer();

  Future<void> add(Map<String, dynamic> data) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    await api.add(url: searchURL(id), data: data);
  }

  Future<void> delete(String idd) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    await api.delete(url: searchURL(id), id: idd);
  }
}
