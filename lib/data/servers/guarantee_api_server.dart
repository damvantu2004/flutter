import 'base_api_server.dart';

class GuaranteeAPIServer {
  String url() => "guarantees_doing";

  static BaseAPIServer api = BaseAPIServer();

  Future<void> add(Map<String, dynamic> data) async {
    String ramdomIDFolder = api.getRandomString(15);
    List<String> getURLdownload = await api.uploadFilesList(
        'image_guarantees/$ramdomIDFolder', data["imagePath"]);
    data["imagePath"] = getURLdownload;
    await api.add(url: url(), data: data);
  }
}
