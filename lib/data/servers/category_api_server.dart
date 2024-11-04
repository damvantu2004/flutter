import 'package:flutter/foundation.dart';
import 'package:furniture_app/data/models/category.dart';
import 'package:furniture_app/data/servers/base_api_server.dart';

class CategoryAPIServer {
  final String imageCategoryURL = "/image_category";
  final String categoryURL = "/category";

  static BaseAPIServer api = BaseAPIServer();
}
