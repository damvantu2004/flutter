import 'package:furniture_app/data/models/category.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/category_repository.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

import '../../../data/models/cart.dart';
import '../../../data/repository/cart_repository.dart';
import '../../product_detail/view/product_detail_page.dart';

class HomeController extends GetxController {
  List<MyCategory> menu = [];
  List<Product> products = [];
  List<Cart> carts = [];
  int currentIndex = 0;
  late UserProfile currenUser;
  bool sort = false;
  bool sortIncreate = false;
  bool loadDataProduct = true;
  bool loadDatacategory = true;
  @override
  void onInit() {
    super.onInit();
    loadInit();
  }

  Future<void> loadInit() async {
    print("init nè");
    currenUser = await UserRepository().getUserProfile();
    menu = await CategoryRepository().getCategories();
    carts = await CartRepository().getAllMyCarts();
    loadDatacategory = false;
    update();
    await loadProduct('all');
  }

  Future<void> loadProduct(String category) async {
    sort = false;
    loadDataProduct = true;
    update();
    print(category);
    products = await ProductRepository().getProducts(category);
    print("Products nè");
    print(products);
    loadDataProduct = false;
    update();
  }

  Future<void> updateFirebase(List<Product> products) async {
    // // Update product
    List<String?> images = [];

    // deleted
    // for (int i = 0; i < products.length; i++) {
    //   print('index: $i');
    //   var obj = images.firstWhere((element) => element == products[i].imagePath?[0], orElse: () => null);
    //   if (obj == null) {
    //     images.add(products[i].imagePath![0]);
    //     print(products[i].id);
    //   } else {
    //     await ProductRepository().deletedProduct(products[i]);
    //   }
    // }

    //set
    // for (int i = 0; i < products.length; i++) {
    //   print('index: $i');
    //   products[i].isDeleted = null;
    //   products[i].linkAR = null;
    //   await ProductRepository().setProduct(products[i]);
    // }
  }

  Future<void> sortProduct() async {
    if (sort == false) {
      sort = true;
    } else {
      if (sortIncreate) {
        sortIncreate = false;
      } else {
        sortIncreate = true;
      }
    }
    products = await ProductRepository().getProductsSortByPrice(menu[currentIndex].path.toString(), sortIncreate);
    if (products.isEmpty) {
      print("No products found after sorting");
    }
    update();
  }

  void onSeletedMenu(int index) {
    currentIndex = index;
    loadProduct(menu[currentIndex].path.toString());
    update();
  }

  Future<void> clickProduct(Product product) async {
    bool load = await Get.to(ProductDetailPage(), arguments: {
      "product": product,
      "favorite": currenUser.checkFavories(product.id.toString()),
      "cart": currenUser.checkCart(product.id.toString()),
    });
    if (load) currenUser = await UserRepository().getUserProfile();
  }

  Future<void> filterBy(Map<String, dynamic> data) async {
    products = [];
    update();
    products = await ProductRepository().getProductsFilterBy(data);
    update();
  }
}
