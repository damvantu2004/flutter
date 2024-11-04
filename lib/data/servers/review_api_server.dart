import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class ReviewAPIServer {
  String reviewUrl() => "reviews";
  String reviewProductUrl(String category, String productID) => "/category/$category/products/$productID/reviews";
  static BaseAPIServer api = BaseAPIServer();
  Future<void> updateReview(Map<String, dynamic> data, String id, Product product) async {
    if (data['imagePath'] != null && (data['imagePath'] as List<String>).length > 0) {
      String ramdomIDFolder = api.getRandomString(15);
      List<String> getURLdownloads = await api.uploadFilesList('image_review/$ramdomIDFolder', data["imagePath"]);
      data["imagePath"] = getURLdownloads;
    }
    await api.update(
        url: reviewUrl(),
        data: {
          'content': data['content'],
          'numberStart': data['numberStart'],
          'imagePath': data['imagePath'],
        },
        id: id);
    if (product.category != null && product.id != null) {
      await api.set(
          url: reviewProductUrl(product.category!, product.id!),
          data: {
            'orderID': data['orderID'],
            'userID': data['userID'],
            'user': data['user'],
            'content': data['content'],
            'numberStart': data['numberStart'],
            'imagePath': data['imagePath'],
            'reply': null,
            'adminID': null,
          },
          id: id);
    }
  }
}
