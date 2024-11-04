import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class MessageAPIServer {
  String urlMessage(String s) => "chatroom/$s/message";
  String urlRoom() => "chatroom";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.add(url: urlMessage(idUser), data: data);
  }

  Future<void> setChatRoom(Map<String, dynamic> data) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.set(url: urlRoom(), data: data, id: idUser);
  }

  Future<void> updateChatRoom(Map<String, dynamic> data) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.update(url: urlRoom(), data: data, id: idUser);
  }

  Future<void> delete(String id) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    await api.delete(url: urlMessage(idUser), id: id);
  }
}
