import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class ProductAPIServer {
  final String productURL = "/products";
  final String categoryURL = "/category";
  final String allUrl = "/category/all/products";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> update(Map<String, dynamic> data, String id) async {
    await api.update(url: allUrl, data: data, id: id);
    await api.update(url: "$categoryURL/${data['category']}$productURL", data: data, id: id);
  }

  Future<void> set(Map<String, dynamic> data, String id) async {
    await api.set(url: allUrl, data: data, id: id);
    // await api.set(url: "$categoryURL/${data['category']}/products", id: id, data: data);
  }

  Future<void> delete(String category, String id) async {
    await api.delete(url: allUrl, id: id);
    await api.delete(url: "$categoryURL/$category/products", id: id);
  }
}
