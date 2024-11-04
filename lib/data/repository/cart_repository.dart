import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/servers/card_api_server.dart';
import 'package:furniture_app/data/servers/cart_api_server.dart';

import '../models/cart.dart';

class CartRepository {
  CartAPIServer cartAPIServer = CartAPIServer();
  Future<void> addToCart(Cart cart) async {
    Cart? f = await findProductOnCarts(cart);
    if (f != null) {
      Map<String, dynamic> data = {
        'amount': f.amount + cart.amount
      };
      await cartAPIServer.update(f.id, data);
    } else {
      print("This is product not in cart");
      await cartAPIServer.add(cart.toJson());
    }
  }

  Future<void> deleteCart(String id) async {
    await cartAPIServer.delete(id);
  }

  Future<List<Cart>> getAllMyCarts() async {
    String idUser = FirebaseAuth.instance.currentUser!.uid.toString();
    CollectionReference collection = FirebaseFirestore.instance.collection('users').doc(idUser).collection('cart');
    List<Cart> carts = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      carts = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Cart a = Cart.fromJson(data, id: doc.id);
          return a;
        }
        return Cart();
      }).toList();
    });
    print(carts);
    return carts;
  }

  Query compareTo(CollectionReference c, Cart cart) {
    Map<String, dynamic> data = cart.toJson();
    return c.where("color", isEqualTo: data['color']).where("id_product", isEqualTo: data['id_product']).where("height", isEqualTo: data['height']).where("width", isEqualTo: data['width']).where("length", isEqualTo: data['length']).where("price", isEqualTo: data['price']);
  }

  Future<Cart?> findProductOnCarts(Cart cart) async {
    String idUser = FirebaseAuth.instance.currentUser!.uid.toString();
    CollectionReference collection = FirebaseFirestore.instance.collection('cart');
    Cart? foundCart;

    await collection
        .where("userId", isEqualTo: idUser)
        .limit(1) // We only need to check if at least one document exists
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        foundCart = Cart.fromJson(data, id: doc.id);
      }
    });

    return foundCart;
  }

  Future<void> deleteCarts(List<Cart> carts) async {
    for (int i = 0; i < carts.length; i++) {
      await deleteCart(carts[i].id);
    }
  }
}
