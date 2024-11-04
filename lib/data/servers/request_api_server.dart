import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class RequestOrderAPIServer {
  String oderUrl() => "request_order";

  static BaseAPIServer api = BaseAPIServer();

  Future<void> add(Map<String, dynamic> data) async {
    String ramdomIDFolder = api.getRandomString(15);
    List<String> getURLdownload = await api.uploadFilesList('image_request_order/$ramdomIDFolder', data["image_path"]);
    data["image_path"] = getURLdownload;
    await api.add(url: oderUrl(), data: data);
  }
}
