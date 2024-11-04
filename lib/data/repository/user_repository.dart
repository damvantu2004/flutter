import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/servers/user_api_server.dart';
import '../models/user_profile.dart';

class UserRepository {
  UserAPIServer userAPIServer = UserAPIServer();

  Future<void> createUser(String id, UserProfile user) async {
    Map<String, dynamic> data = user.toJson();
    if (id != "") await userAPIServer.add(id, data);
  }

  Future<void> seemProduct(Product product) async {
    await UserAPIServer().addViewProduct({
      "id": product.id,
      "recently_viewed": Timestamp.now()
    });
  }

  Future<UserProfile> getUserProfile() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('users');
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    UserProfile user = UserProfile();
    await collection.doc(userID).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        user = UserProfile.fromJson(data, userID);
      }
    });
    return user;
  }

  Future<void> updateUser(UserProfile user, {bool updateImage = false}) async {
    Map<String, dynamic> data = user.toJson();
    await userAPIServer.update(data, updateImage: updateImage);
  }

  Future<List<Product>> getProductSeemRecently({limit = 0}) async {
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    CollectionReference collection = FirebaseFirestore.instance.collection('users').doc(userID).collection('seem_product');
    List<String> listId = [];
    await collection.orderBy("recently_viewed", descending: true).limit(limit).get().then((QuerySnapshot querySnapshot) {
      listId = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          return doc.id;
        }
        return "";
      }).toList();
    });
    List<Product> products = [];
    for (int i = 0; i < listId.length; i++) {
      products.add(await ProductRepository().getProduct(listId[i]));
    }
    return products;
  }

  int find(List<String> lists, String item) {
    for (int i = 0; i < lists.length; i++) {
      if (lists[i] == item) return i;
    }
    return -1;
  }

  Future<void> updateFavorite(String id, bool add) async {
    UserProfile user = await getUserProfile();
    if (user.favories == null) user.favories = [];
    if (add) {
      int index = find(user.favories!, id);
      if (index == -1) {
        user.favories!.add(id);
        Map<String, dynamic> data = {
          'favories': user.favories
        };
        userAPIServer.update(data); //user.id.toString(),
      }
    } else {
      int index = find(user.favories!, id);
      if (index != -1) {
        user.favories!.removeAt(index);
        Map<String, dynamic> data = {
          'favories': user.favories
        };
        userAPIServer.update(data); //user.id.toString(),
      }
    }
  }
}
