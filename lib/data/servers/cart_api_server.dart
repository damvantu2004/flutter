import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class CartAPIServer {
  String cartUrl(String s) => "users/$s/cart";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.add(url: cartUrl(idUser), data: data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.update(url: cartUrl(idUser), data: data, id: id);
  }

  Future<void> delete(String id) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.delete(url: cartUrl(idUser), id: id);
  }
}
