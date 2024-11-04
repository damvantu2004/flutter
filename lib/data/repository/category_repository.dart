import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/data/models/category.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/servers/category_api_server.dart';
import 'package:furniture_app/data/servers/product_api_server.dart';

class CategoryRepository {
  CategoryAPIServer categoryAPIServer = CategoryAPIServer();

  Future<List<MyCategory>> getImageCategories() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('image_category');
    List<MyCategory> categories = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      categories = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyCategory a = MyCategory.fromJson(data, doc.id);
          return a;
        }
        return MyCategory();
      }).toList();
    });
    return categories;
  }

  Future<List<MyCategory>> getCategories() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('category');
    List<MyCategory> categories = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      categories = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyCategory a = MyCategory.fromJson(data, doc.id);
          return a;
        }
        return MyCategory();
      }).toList();
    });
    return categories;
  }

  String format(String st) {
    String re = st.trim();
    re = re.replaceAll("  ", " ");
    print(re);
    return re;
  }

  String getPath(String st) {
    String re = st.trim();
    re = re.toLowerCase();
    re = re.replaceAll("  ", " ");
    re = re.replaceAll(" ", "_");
    print(re);
    return re;
  }
}
