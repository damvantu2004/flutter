import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class AddressAPIServer {
  static BaseAPIServer api = BaseAPIServer();
  String url(String userID) => 'users/$userID/address';

  Future<void> update(String id, Map<String, dynamic> data) async {
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    await api.update(id: id, url: url(userID), data: data);
  }

  String urlListAddress(String idUser) =>
      "/users/$idUser/address/address/lists";
  String urlAddress(String idUser) => "/users/$idUser/address";

  Future<void> addAdress(String idUser, Map<String, dynamic> data) async {
    String idAddress = await api.add(url: urlListAddress(idUser), data: data);
    await api.set(
        id: "address", url: urlAddress(idUser), data: {'default': idAddress});
  }

  Future<void> delete(String id) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.delete(url: urlListAddress(idUser), id: id);
  }
}
