import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/servers/product_api_server.dart';

class ProductRepository {
  ProductAPIServer productAPIServer = ProductAPIServer();

  Future<void> updateProduct(Product product) async {
    try {
      if (product.id != null) {
        await productAPIServer.update(product.toJson(), product.id!);
      }
    } catch (e) {
      print('Error in updateProduct: $e');
    }
  }

  Future<List<Product>> getProducts(String category) async {
    List<Product> products = [];
    try {
      // Adjust the path to point to 'category -> all -> products'
      CollectionReference collection = FirebaseFirestore.instance
          .collection('category')
          .doc(category)
          .collection('products');
      QuerySnapshot querySnapshot = await collection.get();

      print('QuerySnapshot data:');
      querySnapshot.docs.forEach((doc) {
        print(doc.data()); // Print each document's data
      });

      products = querySnapshot.docs
          .map((doc) {
            if (doc.exists && doc.data() != null) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              if (data['is_deleted'] == null || data['is_deleted'] == false) {
                return Product.fromJson(data, doc.id);
              }
            }
            return null;
          })
          .whereType<Product>()
          .toList();
    } catch (e) {
      print('Error in getProducts: $e');
    }

    print(products);
    return products;
  }

  Future<List<Product>> getRecentlyProducts({int limit = 4}) async {
    List<Product> products = [];
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('users')
          .doc(AuthService.userId)
          .collection('seem_product');
      await collection
          .orderBy("recently_viewed", descending: true)
          .limit(limit)
          .get()
          .then((QuerySnapshot querySnapshot) {
        products = querySnapshot.docs.map((doc) {
          if (doc.exists) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Product a = Product.fromJson(data, doc.id);
            return a;
          }
          return Product();
        }).toList();
      });
    } catch (e) {
      print('Error in getRecentlyProducts: $e');
    }
    return products;
  }

  Future<List<Product>> getHotProducts() async {
    List<Product> products = [];
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('category')
          .doc('all')
          .collection('products');
      await collection
          .where('is_hot', isEqualTo: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        products = querySnapshot.docs.map((doc) {
          if (doc.exists) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Product a = Product.fromJson(data, doc.id);
            return a;
          }
          return Product();
        }).toList();
      });
    } catch (e) {
      print('Error in getHotProducts: $e');
    }
    return products;
  }

  List<String> _toStringArray(String st) {
    List<String> re = [];
    try {
      st = st.trim();
      st = st.replaceAll("  ", " ");
      if (st != "") {
        re = st.toLowerCase().split(" ");
      }
    } catch (e) {
      print('Error in _toStringArray: $e');
    }
    return re;
  }

  Future<List<Product>> searchProducts(String search) async {
    List<Product> products = [];
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('category')
          .doc('all')
          .collection('products');

      // Retrieve all documents
      await collection.get().then((QuerySnapshot querySnapshot) {
        products = querySnapshot.docs.map((doc) {
          if (doc.exists) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Product product = Product.fromJson(data, doc.id);

            // Check if the name contains the search string
            if (product.name != null && product.name!.toLowerCase().contains(search.toLowerCase())) {
              return product;
            }
          }
          return null; // Return null if it doesn't match
        }).where((product) => product != null).cast<Product>().toList();
      });
    } catch (e) {
      print('Error in searchProducts: $e');
    }

    print("This is result of search");
    print(products);
    return products;
  }

  Future<List<Product>> getProductsSortByPrice(
      String category, bool asc) async {
    List<Product> products = [];
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('category')
          .doc("all")
          .collection('products');
      await collection
          .orderBy('price', descending: asc)
          .get()
          .then((QuerySnapshot querySnapshot) {
        products = querySnapshot.docs.map((doc) {
          if (doc.exists) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Product a = Product.fromJson(data, doc.id);
            return a;
          }
          return Product();
        }).toList();
      });
    } catch (e) {
      print('Error in getProductsSortByPrice: $e');
    }
    return products;
  }

  Query filterBy(CollectionReference c, Map<String, dynamic> data) {
    Query t = c;
    try {
      if (data['color'] != null && data['color'].length > 0) {
        List<String> color = toListString(data['color'] as List<Color>);
        t = t.where('image_color_theme', arrayContainsAny: color);
      }
    } catch (e) {
      print('Error in filterBy: $e');
    }
    return t;
  }

  List<String> toListString(List<Color> c) {
    List<String> re = [];
    try {
      c.forEach((element) {
        String t = element.toString().replaceAll("Color(", "");
        t = t.replaceAll(")", "");
        re.add(t);
      });
    } catch (e) {
      print('Error in toListString: $e');
    }
    return re;
  }

  Future<List<Product>> getProductsFilterBy(Map<String, dynamic> data) async {
    List<Product> products = [];
    List<Product> productsFilter = [];
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('category')
          .doc('all')
          .collection('products');
      print("This is data for filtering");
      print(data);
      await filterBy(collection, data)
          .get()
          .then((QuerySnapshot querySnapshot) {
        products = querySnapshot.docs.map((doc) {
          if (doc.exists) {
            Map<String, dynamic> dataProduct =
                doc.data() as Map<String, dynamic>;
            Product a = Product.fromJson(dataProduct, doc.id);
            if (checkProduct(data, a)) {
              productsFilter.add(a);
            }
            return a;
          }
          return Product();
        }).toList();
      });
    } catch (e) {
      print('Error in getProductsFilterBy: $e');
    }
    return productsFilter;
  }

  bool checkPrice(double? data, double? price) {
    try {
      if (data != null && data > 0) {
        if (data > price!) {
          return true;
        }
        return false;
      }
    } catch (e) {
      print('Error in checkPrice: $e');
    }
    return true;
  }

  bool checkCategory(List<String>? data, String category) {
    try {
      if (data != null && data.length > 0) {
        for (int i = 0; i < data.length; i++) {
          if (data[i] == category) {
            return true;
          }
        }
        return false;
      }
    } catch (e) {
      print('Error in checkCategory: $e');
    }
    return true;
  }

  bool checkProduct(Map<String, dynamic> data, Product product) {
    try {
      if (checkPrice(double.parse(data['price'].toString()), product.price) &&
          checkCategory(data['path'], product.category ?? "")) return true;
    } catch (e) {
      print('Error in checkProduct: $e');
    }
    return false;
  }

  Future<Product> getProduct(String id) async {
    Product product = Product();
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('category')
          .doc('all')
          .collection('products');
      await collection.doc(id).get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          print("Get data in cart");
          print(data);
          product = Product.fromJson(data, id);
        }
      });
    } catch (e) {
      print('Error in getProduct: $e');
    }
    return product;
  }

  Future<void> setProduct(Product product) async {
    try {
      if (product.id != null) {
        await productAPIServer.set(product.toJson(), product.id!);
      }
    } catch (e) {
      print('Error in setProduct: $e');
    }
  }

  Future<void> deletedProduct(Product product) async {
    try {
      await productAPIServer.delete(product.category ?? "", product.id ?? "");
    } catch (e) {
      print('Error in deletedProduct: $e');
    }
  }
}
