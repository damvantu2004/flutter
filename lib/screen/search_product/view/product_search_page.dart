import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/screen/search_product/controller/search_controller.dart';
import 'package:get/get.dart';

class ProductSearchPage extends GetView<SearchPageController> {
  ProductSearchPage({super.key});
  CollectionReference users = FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: _appBar(),
              body: buildProducts(),
            ));
  }

  Widget buildProducts() {
    return Container(
      height: Get.height - 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MasonryGridView.count(
        itemCount: controller.products.length,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        itemBuilder: (context, index) {
          return productItem(controller.products[index]);
        },
      ),
    );
  }

  Widget productItem(Product product) {
    double height = (Get.width - 60) / 2 * 0.7;
    if (height > 200) height = 200;

    // Provide a fallback image if the imagePath list is empty or null
    final imageUrl =
    (product.imagePath != null && product.imagePath!.isNotEmpty)
        ? product.imagePath![0]
        : 'https://via.placeholder.com/150'; // Fallback image URL

    return InkWell(
      onTap: () {
        controller.clickProduct(product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name.toString(),
            style: TextStyle(fontFamily: jose_fin_sans, color: textGrey2Color),
          ),
          const SizedBox(height: 10),
          Text(
            "\$ ${product.price}",
            style: TextStyle(fontFamily: jose_fin_sans, color: textBlackColor),
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: const BackButton(color: Colors.black),
      elevation: 0,
      backgroundColor: backgroundColor,
      title: TextField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
          prefixIcon: Icon(
            Icons.search,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: Color.fromRGBO(158, 158, 158, 1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
        ),
        onSubmitted: (value) {
          controller.loadSearch(value, load: true);
        },
      ),
    );
  }
}
