import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class UserAPIServer {
  final String userURL = "/users";

  static BaseAPIServer api = BaseAPIServer();

  Future<void> add(String id, Map<String, dynamic> data) async {
    await api.set(id: id, url: userURL, data: data);
  }

  Future<void> update(Map<String, dynamic> data, {bool updateImage = false}) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    if (updateImage) {
      try {
        await FirebaseStorage.instance.ref('image_avata/$id/').delete();
      } catch (e) {}
      String getURLdownload = await api.uploadFiles('image_avata/$id', data["avatar"]);
      data["avatar"] = getURLdownload;
    }
    await api.update(id: id, url: userURL, data: data);
  }

  Future<void> addViewProduct(Map<String, dynamic> data) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    await api.set(url: "$userURL/$id/seem_product", id: data['id'], data: data);
  }
}
