import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class DiscountAPIServer {
  String url(String id) => "/users/${id}/discounts";

  static BaseAPIServer api = BaseAPIServer();

  Future<void> set(Map<String, dynamic> data, String id) async {
    if (id != 'null') await api.set(url: url(AuthService.userId!), data: data, id: id);
  }
}
