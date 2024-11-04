import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class CardAPIServer {
  static BaseAPIServer api = BaseAPIServer();
  String url(String userID) => 'users/$userID/card';

  Future<void> update(String id, Map<String, dynamic> data) async {
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    await api.update(id: id, url: url(userID), data: data);
  }

  String urlListCard(String idUser) => "/users/$idUser/card/card/lists";
  String urlCard(String idUser) => "/users/$idUser/card";

  Future<void> addCard(String idUser, Map<String, dynamic> data) async {
    String idCard = await api.add(url: urlListCard(idUser), data: data);
    await api.set(id: "card", url: urlCard(idUser), data: {
      'default': idCard
    });
  }
}
