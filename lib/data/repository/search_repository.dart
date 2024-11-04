import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/category.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/category_repository.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/servers/search_api_server.dart';
import 'package:get/get.dart';

class SearchRepository {
  SearchAPIServer searchAPIServer = SearchAPIServer();

  Future<void> updateDataSearch() async {
    List<Product> products = await ProductRepository().getProducts('all');
    List<MyCategory> categorys = await CategoryRepository().getCategories();
    Map<String, String> categoryName = {};
    for (int i = 0; i < categorys.length; i++) {
      if (categorys[i].path != null && categorys[i].name != null) {
        categoryName[categorys[i].path!] = categorys[i].name!;
      }
    }
    for (int i = 0; i < products.length; i++) {
      if (categoryName[products[i].category] != null) {
        products[i].search = getNameProductSearchArray(
            products[i], categoryName[products[i].category]!);
        await ProductRepository().updateProduct(products[i]);
      }
    }
  }

  Future<void> deletedProduct(String id) async {
    await searchAPIServer.delete(id);
  }

  List<String> getNameProductSearchArray(Product product, String categoryName) {
    List<String> re = [];
    product.name = product.name ?? "";
    product.name = product.name!.trim();
    product.name = product.name!.replaceAll("  ", " ");
    if (product.name != "") {
      re = product.name!.toLowerCase().split(" ");
    }
    re.addAll(categoryName.toLowerCase().split(" ") as Iterable<String>);
    return re;
  }

  Future<void> addMessSearch(String mess) async {
    await SearchAPIServer().add({"text": mess});
  }

  Future<List<String>> getMessSearch({int limit = 0}) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference collection = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('search');
    List<String> mess = [];
    await collection
        .orderBy("created_time", descending: true)
        .limit(limit)
        .get()
        .then((QuerySnapshot querySnapshot) {
      mess = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return data['text'].toString();
        }
        return "";
      }).toList();
    });
    return mess;
  }
}
